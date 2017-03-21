api_log () {
  sudo tail -f /var/log/uwsgi/app/api.log | awk '{ print $15 "\t" $24 "\t" $17 "\t (" $27 "\t" $18}'
}

