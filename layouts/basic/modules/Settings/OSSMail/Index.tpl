{*<!-- {[The file is published on the basis of YetiForce Public License 3.0 that can be found in the following directory: licenses/LicenseEN.txt or yetiforce.com]} -->*}
{strip}
	<div class="verticalScroll">
		<div class="widget_header row">
			<div class="col-12">
				{include file=\App\Layout::getTemplatePath('BreadCrumbs.tpl', $MODULE)}
			</div>
		</div>
		<h5>{\App\Language::translate('Roundcube config', $MODULE)}</h5>
		{if Settings_ModuleManager_Library_Model::checkLibrary('roundcube')}
			<div class="alert alert-danger" role="alert">
				<div>
					<h4>{\App\Language::translateArgs('ERR_NO_REQUIRED_LIBRARY', 'Settings:Vtiger','roundcube')}</h4>
				</div>
			</div>
		{elseif !\App\Module::isModuleActive('OSSMail')}	
			<div class="alert alert-danger" role="alert">
				<div>
					<h4>{\App\Language::translate('ERR_NO_MODULE_IS_INACTIVE', $QUALIFIED_MODULE)}</h4>
				</div>
			</div>
		{else}
			<form class="roundcubeConfig">
				<div class="col-md-12 marginTop20">
					<input type="hidden" name="module" value="{$MODULE}">
					<input type="hidden" name="parent" value="Settings">
					<input type="hidden" name="action" value="Save">
					{foreach key=FIELD_NAME item=FIELD_DETAILS from=$RECORD_MODEL->getForm()}
						<div class="row marginBottom10px">
							<div class="row col-md-4">
								<label class="muted ">{if $FIELD_DETAILS['required'] === 1}<span class="redColor">*</span>{/if}{\App\Language::translate($FIELD_DETAILS['label'], $MODULE)}</label></td>
							</div>
							<div class="col-md-8">
								{if $FIELD_DETAILS['fieldType'] === 'picklist'}
									<div class=" row col-sm-12">
										<select class="select2 form-control" name="{$FIELD_NAME}">
											{foreach item=ELEMENT from=$FIELD_DETAILS['value']}
												<option value="{$ELEMENT}" {if $ELEMENT == $RECORD_MODEL->get($FIELD_NAME)} selected {/if}>
													{if $FIELD_NAME !== 'language'}
														{\App\Language::translate($FIELD_NAME|cat:'_'|cat:$ELEMENT, $MODULE)}
													{else}
														{$ELEMENT}
													{/if}
												</option>
											{/foreach}
										</select>
									</div>
								{else if $FIELD_DETAILS['fieldType'] === 'multipicklist'}
									<div class="row col-md-12">
										<select class="form-control" name="{$FIELD_NAME}" multiple {if $FIELD_DETAILS['required'] === 1}data-validation-engine="validate[required]"{/if}>
											{foreach item=ITEM key=KEY from=$RECORD_MODEL->get($FIELD_NAME)}
												<option value="{$KEY}" selected>{$KEY}</option>
											{/foreach}
										</select>
									</div>
								{else if $FIELD_DETAILS['fieldType'] === 'checkbox'}
									<div class=" row col-sm-12">
										<input type="hidden" name="{$FIELD_NAME}" value="false" />
										<input type="checkbox" name="{$FIELD_NAME}" value="true" {if $RECORD_MODEL->get($FIELD_NAME) == 'true'} checked {/if} />
									</div>
								{else}
									<div class="row col-sm-12">
										<input class="form-control" type="text" name="{$FIELD_NAME}" {if $FIELD_DETAILS['required'] === 1}data-validation-engine="validate[required]"{/if} value="{$RECORD_MODEL->get($FIELD_NAME)}" />
									</div>
								{/if}
							</div>
						</div>
					{/foreach}

				</div>
				<div class="c-form__action-panel {if AppConfig::module('Users', 'IS_VISIBLE_USER_INFO_FOOTER')} c-form__action-panel-mobile {/if}">
					<button class="btn btn-success saveButton" type="submit" title=""><strong>{\App\Language::translate('LBL_SAVE', $MODULE)}</strong></button>
				</div>
		</div>
	</form>
{/if}
{/strip}
