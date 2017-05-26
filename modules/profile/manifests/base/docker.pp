# Contains all development specific stuff on vagrant boxes
class profile::base::docker()
{
    $required_packages = [
      'bc',
      'mlocate',
      'psmisc',
      'unzip',
    ]

    package{ $required_packages:
      ensure => 'installed',
    }

}
