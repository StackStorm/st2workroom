class role::st2factory {
  include ::profile::infrastructure
  include ::profile::docker
  include ::profile::packer
  include ::profile::ruby
  include ::st2::profile::python
}
