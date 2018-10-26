module ManageIQ::Providers::Aliyun::ManagerMixin
  extend ActiveSupport::Concern

  included do
    validates :provider_region, :inclusion => {:in => ->(_region) { ManageIQ::Providers::Aliyun::Regions.names }}
  end

  def description
    ManageIQ::Providers::Aliyun::Regions.find_by_name(provider_region)[:description]
  end

  #
  # Connections
  #

  def connect(options = {})
    raise "no credentials defined" if missing_credentials?(options[:auth_type])

    username = options[:user] || authentication_userid(options[:auth_type])
    password = options[:pass] || authentication_password(options[:auth_type])
    service  = options[:service] || :Compute
    proxy    = options[:proxy_uri] || http_proxy_uri
    region   = options[:region] || provider_region


    self.class.raw_connect(username, password, service, region, proxy)
  end

  def verify_credentials(auth_type = nil, options = {})
    raise MiqException::MiqHostError, "No credentials defined" if missing_credentials?(auth_type)

    return true if auth_type == "smartstate_docker"
    self.class.connection_rescue_block do
      with_provider_connection(options.merge(:auth_type => auth_type)) do |aliyun|
        self.class.validate_connection(aliyun)
      end
    end

    true
  end

  module ClassMethods
    #
    # Connections
    #

    def raw_connect(access_key_id, secret_access_key,service,region, proxy_uri = nil, validate = false)
      require 'fog/aliyun'

      connection = ::Fog::const_get(service).new(
          :provider                 => "aliyun",
          :aliyun_url               => "https://ecs.aliyuncs.com/",
          :aliyun_accesskey_id      => access_key_id,
          :aliyun_accesskey_secret  => MiqPassword.try_decrypt(secret_access_key),
          :aliyun_region_id         => region
      )

      connection
    end

    def validate_connection(connection)
      connection_rescue_block do
        connection.regions.all.map(&:id)
      end
    end

    def connection_rescue_block
      yield
    rescue => err
      miq_exception = translate_exception(err)
      raise unless miq_exception

      _log.error("Error Class=#{err.class.name}, Message=#{err.message}")
      raise miq_exception
    end

    def translate_exception(err)
      MiqException::MiqHostError.new "#{err.message}"
    end

  end
end
