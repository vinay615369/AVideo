<?php

//streamer config
require_once '../videos/configuration.php';

if (!isCommandLineInterface()) {
    return die('Command Line only');
}

AVideoPlugin::loadPlugin("Live");

$channelName = $global['mysqli']->real_escape_string($channelName);
$sql = "SELECT lt.*, u.* FROM users u LEFT JOIN live_transmitions lt ON users_id = u.id "
        . " WHERE canStream = 1 AND status = 'a' LIMIT 20";
$res = sqlDAL::readSql($sql);
$users = sqlDAL::fetchAllAssoc($res);
sqlDAL::close($res);
if ($res != false) {
    foreach ($users as $row) {
        echo "-----------------------------------".PHP_EOL;
        echo "{$row['id']} - {$row['user']} ".PHP_EOL;
        echo Live::getServer() . "?p=" . $row['password'] . "/" . $row['key'].PHP_EOL;        
        echo "-----------------------------------".PHP_EOL;
    }
}
die();




