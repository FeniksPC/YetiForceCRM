{*<!-- {[The file is published on the basis of YetiForce Public License 3.0 that can be found in the following directory: licenses/LicenseEN.txt or yetiforce.com]} -->*}
{strip}
	<div class="tpl-EditViewActions c-form__action-panel {if AppConfig::module('Users', 'IS_VISIBLE_USER_INFO_FOOTER')} c-form__action-panel-mobile {/if}">
		<button class="btn btn-success js-generatePass mr-1" name="save" type="button">
			<span class="fas fa-key mr-1"></span>
			<strong class="d-none d-md-inline-block">{\App\Language::translate($GENERATEPASS, $MODULE)}</strong>
		</button>
		<button class="btn btn-success mr-1" type="submit">
			<span class="fas fa-check mr-1"></span>
			<strong class="d-none d-md-inline-block">{\App\Language::translate('LBL_SAVE', $QUALIFIED_MODULE_NAME)}</strong>
		</button>
		<button class="cancelLink btn btn-danger" type="reset" onclick="javascript:window.history.back();">
			<span class="fas fa-times mr-1"></span>
			<strong class="d-none d-md-inline-block">{\App\Language::translate('LBL_CANCEL', $QUALIFIED_MODULE_NAME)}</strong>
		</button>
		{foreach item=LINK from=$EDITVIEW_LINKS['EDIT_VIEW_HEADER']}
			{include file=\App\Layout::getTemplatePath('ButtonLink.tpl', $MODULE) BUTTON_VIEW='editViewHeader'}
		{/foreach}
	</div>
	</form>
	</div>
	</div>
{/strip}
