#!/bin/sh /etc/rc.common

. /lib/functions/system.sh

START=99

#####################################
# Helper functions for wlan ready
#####################################

hostapd_ready()
{
        hostapd_cli -i$1 stat &>/dev/null
}

wlan_reset()
{
        wifi down
        sleep 2
        wifi
}

wlan_ready()
{
        hostapd_ready wlan0 && hostapd_ready wlan2
}

wlan_ready_poll()
{
        local delay=${1-3}
        while [ 0 == 0 ]; do
                if ! wlan_ready; then echo "$0: wlan not ready" > /dev/console; else break; fi
                sleep $delay
        done
}

####################
# main
####################

status_function() {
        echo "enable: $(uci get prplmesh.config.enable)" > /dev/console
        echo "management_mode: $(uci get prplmesh.config.management_mode)" > /dev/console
        echo "operating_mode: $(uci get prplmesh.config.operating_mode)" > /dev/console
        wlan_ready && echo "WLAN Ready" > /dev/console || echo "WLAN not ready" > /dev/console
        /opt/prplmesh/prplmesh_utils.sh status
}

start_function() {
        if uci get prplmesh.config.enable > /dev/null; then
                wlan_ready_poll
                if [ "$(uci get prplmesh.config.operating_mode)" = "Gateway" ]; then
                        echo "start prplmesh controller & agent" > /dev/console
                        /opt/prplmesh/prplmesh_utils.sh start
                else
                        echo "start prplmesh agent" > /dev/console
                        /opt/prplmesh/prplmesh_utils.sh start -m A
                fi
        else
                echo "prplmesh Disabled (prplmesh.config.enable=0), skipping..." > /dev/console
                exit 0
        fi
}

stop_function() {
        echo "Stop prplmesh" > /dev/console
        /opt/prplmesh/prplmesh_utils.sh stop
}

enable_function() {
        echo "Enable prplmesh (reboot required)" > /dev/console
        uci set prplmesh.config.enable=1
        uci commit prplmesh
}

disable_function() {
        echo "Disable prplmesh (reboot required)" > /dev/console
        uci set prplmesh.config.enable=0
        uci commit prplmesh
}

start() {
        start_function
}

stop() {
        stop_function
}

restart() {
        stop_function
        #wlan_reset
        start_function
}

status() {
        status_function
}

repeater_mode() {
        uci set prplmesh.config.management_mode='Multi-AP-Agent'
        uci set prplmesh.config.operating_mode='WDS-Repeater'
        uci set prplmesh.config.wired_backhaul=1
        uci set prplmesh.config.master=0
        uci set prplmesh.config.gateway=0
        uci commit prplmesh
        echo "repeater mode set, reboot or restart prplmesh to apply" > /dev/console
}

gateway_mode() {
        uci set prplmesh.config.management_mode='Multi-AP-Controller-and-Agent'
        uci set prplmesh.config.operating_mode='Gateway'
        uci set prplmesh.config.wired_backhaul=0
        uci set prplmesh.config.master=1
        uci set prplmesh.config.gateway=1
        uci commit prplmesh
        echo "gateway mode set, reboot or restart prplmesh to apply" > /dev/console
}

EXTRA_COMMANDS="status repeater_mode gateway_mode"
EXTRA_HELP='''
	status        show service status
	repeater_mode set repeater mode
	gateway_mode  set gateway mode
'''