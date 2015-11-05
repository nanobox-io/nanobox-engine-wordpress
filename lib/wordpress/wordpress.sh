wordpress_create_wordpress_conf() {
  nos_template \
    "wordpress/wp-config-top.php.mustache" \
    "$(nos_code_dir)/wp-config.php" \
    "$(wordpress_conf_payload)"
  cat $(nos_cache_dir)/salt >> $(nos_code_dir)/wp-config.php
  cat ${engine_template_dir}/wordpress/wp-config-bottom.php >> $(nos_code_dir)/wp-config.php
}

wordpress_conf_payload() {
  cat <<-END
{
  "mysql1_name": "$(wordpress_mysql1_name)",
  "mysql1_user": "$(wordpress_mysql1_user)",
  "mysql1_pass": "$(wordpress_mysql1_pass)",
  "mysql1_host": "$(wordpress_mysql1_host)"
}
END
}

wordpress_generate_salt() {
  if [[ ! -f $(nos_cache_dir)/salt ]]; then
    curl -o $(nos_cache_dir)/salt https://api.wordpress.org/secret-key/1.1/salt/
  fi
}

wordpress_mysql1_name() {
  echo $(payload env_MYSQL1_NAME)
}

wordpress_mysql1_user() {
  echo $(payload env_MYSQL1_USER)
}

wordpress_mysql1_pass() {
  echo $(payload env_MYSQL1_PASS)
}

wordpress_mysql1_host() {
  echo $(payload env_MYSQL1_HOST)
}

