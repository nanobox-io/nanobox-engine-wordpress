create_wordpress_conf() {
  template \
    "wordpress/wp-config-top.php.mustache" \
    "$(payload 'code_dir')/wp-config.php" \
    "$(wordpress_conf_payload)"
  cat $(payload 'cache_dir')/salt >> $(payload 'code_dir')/wp-config.php
  cat ${engine_template_dir}/wordpress/wp-config-bottom.php >> $(payload 'code_dir')/wp-config.php
}

wordpress_conf_payload() {
  cat <<-END
{
  "mysql1_name": "$(mysql1_name)",
  "mysql1_user": "$(mysql1_user)",
  "mysql1_pass": "$(mysql1_pass)",
  "mysql1_host": "$(mysql1_host)"
}
END
}

generate_salt() {
  if [[ ! -f $(payload 'cache_dir')/salt ]]; then
    curl -o $(payload 'cache_dir')/salt https://api.wordpress.org/secret-key/1.1/salt/
  fi
}

mysql1_name() {
  echo $(payload env_MYSQL1_NAME)
}

mysql1_user() {
  echo $(payload env_MYSQL1_USER)
}

mysql1_pass() {
  echo $(payload env_MYSQL1_PASS)
}

mysql1_host() {
  echo $(payload env_MYSQL1_HOST)
}

