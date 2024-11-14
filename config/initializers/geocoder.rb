Geocoder.configure(
  timeout: 3,
  lookup: :ipapi_com,
  ip_lookup: :ipapi_com, # Adjusted to :ipapi_com
  cache: nil,
  language: :en,
  use_https: true,
  always_raise: [
    Geocoder::OverQueryLimitError,
    Geocoder::RequestDenied,
    Geocoder::InvalidRequest,
    Geocoder::InvalidApiKey
  ]
)
