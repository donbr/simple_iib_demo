# Docs
class profile::iib::version10_fixpack_8(
  String $source_location,
)
{
  $version = '10.0.0.8'

  iib_install::software { $version:
    source_location => $source_location,
  }
}
