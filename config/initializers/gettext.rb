Vmdb::Gettext::Domains.add_domain(
  'ManageIQ_Providers_Aliyun',
  ManageIQ::Providers::Aliyun::Engine.root.join('locale').to_s,
  :po
)
