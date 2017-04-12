/*
Copyright (C) 2010 kuberam.ro - Claudius Teodorescu. All rights reserved.
 
Released under LGPL License.
*/

eXSLTForms.rte.specificFunctions[ 'CKEditor' ].beforeRendering = function( nativeConfigOptionsObject ) {

	eXSLTForms.registry.plugins[ 'teiann'] = {
		//loading of plugin's modules
		loadingPluginModules : function() {
			var loader = eXSLTForms.utils.loader;
			//loading of the general configuration options
			var generalConfigOptionsDoc = loader( CKEDITOR.basePath + 'plugins/tei-ann/config/generalConfigOptions.xml', 'xml').documentElement;
			eXSLTForms.registry.plugins.teiann[ 'generalConfigOptionsDoc' ] = generalConfigOptionsDoc;

			//loading the annotator specifications
			eXSLTForms.registry.plugins.teiann[ 'annotatorSpecificationsDoc' ] = loader( generalConfigOptionsDoc.querySelector( "specificationFilePath" ).textContent, 'xml').documentElement;
 
// 			//loading the language module
			var editorLangCode = nativeConfigOptionsObject.language == null ? 'en' : nativeConfigOptionsObject.language;
			var pluginLangCode = generalConfigOptionsDoc.querySelector( "lang[code = '" + editorLangCode + "']" ) == null ? 'en' : editorLangCode;
			eXSLTForms.registry.plugins.teiann[ 'pluginLangDoc' ] = loader( CKEDITOR.basePath + 'plugins/tei-ann/config/lang/' + pluginLangCode + '.xml', 'xml').documentElement;
		},
		generateList : function( editor, searchText, annotatorServiceURI ) {
				var serverResponse = eXSLTForms.utils.loader( annotatorServiceURI + searchText, 'xml'),
					listOptions = serverResponse.evaluate("/results/items/item", serverResponse, eXSLTForms.utils.nsResolver, 4, null),
					listOption = listOptions.iterateNext(),
					selectControl = document.getElementById( 'teiannSearchList' );

					//deleting options in list
					selectControl.options.length = 0;

					//adding the new options to list
					while ( listOption ) {
						var newOption = document.createElement( 'option' );
						newOption.text = listOption.getElementsByTagName( 'label' )[0].childNodes[0].nodeValue;
						newOption.value = listOption.getElementsByTagName( 'value' )[0].childNodes[0].nodeValue;
						if ( !Core.isIE ) {
							selectControl.add( newOption, null );
							} else {
							selectControl.add( newOption );
						}
						listOption = listOptions.iterateNext();
					}
					selectControl.selectedIndex = -1;
		},
		splitElement : function( range, toSplit, elementClass ) {
					if ( !range.collapsed )
						return null;
	
					// Extract the contents of the block from the selection point to the end
					// of its contents.
					range.setEndAt( toSplit, CKEDITOR.POSITION_BEFORE_END );
					var documentFragment = range.extractContents();

					if ( documentFragment.$.firstChild.nodeValue !== '') {
						//case when an existing element is splitted
						// Duplicate the element after it.
						var clone = toSplit.clone( false );
			
						// Place the extracted contents into the duplicated element.
						documentFragment.appendTo( clone );
						clone.insertAfter( toSplit );
						range.moveToPosition( toSplit, CKEDITOR.POSITION_AFTER_END );
						return clone;
						} else {
							//case when a new element is created
							var breakObject = CKEDITOR.dom.element.createFromHtml( '<span class="' + elementClass + '">&#160;</span>' );
							breakObject.insertAfter( toSplit );
							var newRange = new CKEDITOR.dom.range( range.document );
							newRange.moveToPosition( breakObject, CKEDITOR.POSITION_BEFORE_END );
							newRange.select();
					}
		},
		addDialogPanel : function( annotatorID, editor ) {
					CKEDITOR.dialog.add( annotatorID + 'Panel', function( editor ) {
						var dialog = '';
						return {
							title : '',
							minWidth : '',
							minHeight : '',
							onLoad : function() {
								dialog = this;
								for ( var i=0 ; i < dialog.definition.contents.length; i++ ) {
									dialog.definition.contents[ i ].onLoad();
									dialog.definition.contents[ i ].onShow();
								}
							},
							onShow : function() {},
							contents : [],
							buttons : [ CKEDITOR.dialog.cancelButton, CKEDITOR.dialog.okButton ],
							onOk : ''	
						};
					});

		}
	};
	eXSLTForms.registry.plugins.teiann.loadingPluginModules();
}