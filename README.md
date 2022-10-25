# turris-utils

- CHANGELOG
  - 2022-10-25 INITIAL RELEASE
  - 2022-10-25 ADDED notify_change_ip.sh
  

- notify_change_ip.sh
  - usefull script thats notify when ip is changed. Must be enabled notifications - https://docs.turris.cz/basics/reforis/notifications/reforis-notifications/
  - Make crontab entry to check ip every 15mins
    - */15 * * * * /srv/custom_scripts/notify_change_ip.sh
