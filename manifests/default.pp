# DEFAULTS
group { 'puppet': ensure => present}
Exec { path => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/', '/usr/local/bin' ]}
File { owner => 0, group => 0, mode => 0644}

package {[
  'build-essential',
  'vim',
  'curl',
  'git-core',
  'libapache2-mod-php5'
]:
  ensure  => 'installed',
}

class { 'apache': }
class { 'apache::mod::rewrite': }

apache::vhost { 'test.typo3.local':
  port => '80',
  docroot => '/var/www/test',
  directories => {
    path => '/var/www/test',
    options => ['FollowSymLinks'],
    allow_override => ['All'],
  },
  require => [ File['/var/www'] ]
}

file { [ '/var/www', '/var/www/cce-gs', '/var/www/cce-gs/web' ]:
  ensure => 'directory',
}

class { '::mysql::client': }
class { '::mysql::server':
  root_password           => 'test',
  remove_default_accounts => true
}

mysql::db { 'typo3':
  user     => 'test',
  password => 'test',
  host     => 'localhost',
  grant    => ['ALL'],
}

typo3::project { 'test':
  version => '6.1.7',
  site_path => '/var/www/test',
  site_user => 'vagrant',
  site_group => 'www-data',
  require => Apache::Vhost['test.typo3.local'],
  use_symlink => false,
  db_name => 'test',
  db_host => 'localhost',
  db_pass => '',
  db_user => 'root',
  local_conf => {
    'sys' => {
      'encryptionKey' => '47ac9add3f53f8464d33ee5785a2f25dc35e8da9fcea8bbc41eb9ced5f58574f326abcecf1924b5ab0d3229c038d7c37',
    },
    'be' => {
      'installToolPassword' => 'bacb98acf97e0b6112b1d1b650b84971',
    },
  },
  extensions => [
    {"key" => "realurl", "repo" => "git://git.typo3.org/TYPO3CMS/Extensions/realurl.git", "tag" => "1_12_6"},
    {"key" => "phpunit", "repo" => "git://git.typo3.org/TYPO3CMS/Extensions/phpunit.git"}
  ]
}
