#!/bin/sh

#Ensure that /var/prometheus/ is accessible
PROM_TEXTFILE_DIR="/var/prometheus/"
[ ! -d $PROM_TEXTFILE_DIR ] && mkdir -p $PROM_TEXTFILE_DIR
#Dont forget to set cron output to $PROM_TEXTFILE_DIR/something.prom
 
SENSORS="$(sensors -j)"

case "$(cat /etc/board.json | jsonfilter -e @.model.name)" in
        "CZ.NIC Turris Mox Board")
                turris_board_type="CZ.NIC Turris Mox Board"
                echo "#TYPE node_hwmon_temp_celsius gauge"
                echo "node_hwmon_temp_celsius{sensor=\"WiFi\",turris_board_type=\"$turris_board_type\"} "$(echo "$SENSORS" | jsonfilter -e '@["mt7915_phy0-pci-0300"].temp1.temp1_input')
                echo "node_hwmon_temp_celsius{sensor=\"CPU\",turris_board_type=\"$turris_board_type\"} "$(echo "$SENSORS" | jsonfilter -e '@["d0032004mdiomii01-mdio-1"].temp1.temp1_input')
                echo "node_hwmon_temp_celsius{sensor=\"Board\",turris_board_type=\"$turris_board_type\"} "$(echo "$SENSORS" | jsonfilter -e '@["socinternalregsd0000000mdio32004switch010mdio01-mdio-1"].temp1.temp1_input')
        ;;
        "Turris Omnia")
                turris_board_type="Turris Omnia"
                echo "#TYPE node_hwmon_temp_celsius gauge"
                echo "node_hwmon_temp_celsius{sensor=\"WiFi\",turris_board_type=\"$turris_board_type\"} "$(echo "$SENSORS" | jsonfilter -e '@["mt7915_phy0-pci-0200"].temp1.temp1_input')
                echo "node_hwmon_temp_celsius{sensor=\"CPU\",turris_board_type=\"$turris_board_type\"} "$(echo "$SENSORS" | jsonfilter -e '@["f10e4078.thermal-virtual-0"].temp1.temp1_input')
                echo "node_hwmon_temp_celsius{sensor=\"Board\",turris_board_type=\"$turris_board_type\"} "$(echo "$SENSORS" | jsonfilter -e '@["f1072004mdiomii01-mdio-1"].temp1.temp1_input')
        ;;
        "Turris")
                turris_board_type="Turris"
                echo "#TYPE node_hwmon_temp_celsius gauge"
                echo "node_hwmon_temp_celsius{sensor=\"CPU\",turris_board_type=\"$turris_board_type\"} "$(echo "$SENSORS" | jsonfilter -e '@["sa56004-i2c-0-4c"].temp2.temp2_input')
                echo "node_hwmon_temp_celsius{sensor=\"Board\",turris_board_type=\"$turris_board_type\"} "$(echo "$SENSORS" | jsonfilter -e '@["sa56004-i2c-0-4c"].temp1.temp1_input')
        ;;
        *)
                :
        ;;
esac

