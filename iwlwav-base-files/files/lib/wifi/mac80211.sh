#!/bin/sh

# source of this file is openwrt/package/kernel/mac80211/files/lib/wifi/mac80211.sh
# we are using the above file as it is which is required to bring wlan as per owrt way.
#
append DRIVERS "mac80211"

detect_mac80211() {
	return 0
}
