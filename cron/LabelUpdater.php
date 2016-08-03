<?php
/**
 * Multi reference value cron
 * @package YetiForce.Cron
 * @license licenses/License.html
 * @author Mariusz Krzaczkowski <m.krzaczkowski@yetiforce.com>
 */
$adb = PearDatabase::getInstance();
$executed = [];
$result = $adb->query("SELECT `vtiger_crmentity`.crmid,`vtiger_crmentity`.setype,`vtiger_crmentity`.crmid,u_yf_crmentity_label.label,u_yf_crmentity_search_label.searchlabel FROM `vtiger_crmentity`LEFT JOIN u_yf_crmentity_label ON u_yf_crmentity_label.crmid = vtiger_crmentity.crmid LEFT JOIN u_yf_crmentity_search_label ON u_yf_crmentity_search_label.crmid = vtiger_crmentity.crmid 
WHERE `vtiger_crmentity`.deleted = '0' AND (u_yf_crmentity_label.label IS NULL OR u_yf_crmentity_search_label.searchlabel IS NULL) LIMIT 1000");
while ($row = $adb->getRow($result)) {
	$updater = false;
	if ($row['label'] === null && $row['searchlabel'] !== null) {
		$updater = 'label';
	} elseif ($row['searchlabel'] === null && $row['label'] !== null) {
		$updater = 'searchlabel';
	}
	\includes\Record::updateLabel($row['setype'], $row['crmid'], 'new', $updater);
}
$result = $adb->query("SELECT `vtiger_crmentity`.crmid,`vtiger_crmentity`.setype FROM `vtiger_crmentity` LEFT JOIN u_yf_crmentity_label ON u_yf_crmentity_label.crmid = vtiger_crmentity.crmid 
LEFT JOIN u_yf_crmentity_search_label ON u_yf_crmentity_search_label.crmid = vtiger_crmentity.crmid WHERE `vtiger_crmentity`.deleted = '0' AND (u_yf_crmentity_label.label = '' OR u_yf_crmentity_search_label.searchlabel = '') LIMIT 1000");
while ($row = $adb->getRow($result)) {
	\includes\Record::updateLabel($row['setype'], $row['crmid']);
}
$result = $adb->query("SELECT `vtiger_crmentity`.crmid,u_yf_crmentity_label.label,u_yf_crmentity_search_label.searchlabel FROM `vtiger_crmentity` 
LEFT JOIN u_yf_crmentity_label ON u_yf_crmentity_label.crmid = vtiger_crmentity.crmid LEFT JOIN u_yf_crmentity_search_label ON u_yf_crmentity_search_label.crmid = vtiger_crmentity.crmid 
WHERE `vtiger_crmentity`.deleted = '1' AND (u_yf_crmentity_label.label IS NOT NULL OR u_yf_crmentity_search_label.searchlabel IS NOT  NULL)");
while ($row = $adb->getRow($result)) {
	if ($row['label'] !== null) {
		$adb->delete('u_yf_crmentity_label', 'crmid = ?', [$row['crmid']]);
	}
	if ($row['searchlabel'] !== null) {
		$adb->delete('u_yf_crmentity_search_label', 'crmid = ?', [$row['crmid']]);
	}
}