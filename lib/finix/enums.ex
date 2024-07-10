defmodule Finix.Enums do
  @moduledoc """

  """
  import EctoEnum

  defenum(AddressVerification, [
    "POSTAL_CODE_AND_STREET_MATCH",
    "STREET_MATCH",
    "POSTAL_CODE_MATCH",
    "NO_ADDRESS",
    "NO_MATCH",
    "NOT_SUPPORTED",
    "UNKNOWN"
  ])

  defenum(BankAccountType, ["CHECKING", "SAVINGS"])

  defenum(BankAccoiuntValidationCheck, ["INCONCLUSIVE", "INVALID", "NOT_ATTEMPTED", "VALID"])

  defenum(CardBrand, [
    "UNKNOWN",
    "DINERS_CLUB_INTERNATIONAL",
    "DANKORT",
    "MIR",
    "TROY",
    "UATP",
    "CHINA_T_UNION",
    "CHINA_UNION_PAY",
    "AMERICAN_EXPRESS",
    "VERVE",
    "RUPAY",
    "DISCOVER",
    "JCB",
    "MASTERCARD",
    "INTERPAYMENT",
    "INSTAPAYMENT",
    "MAESTRO",
    "VISA",
    "LANKAPAY",
    "DINERS_CLUB"
  ])

  defenum(CardType, [
    "CREDIT",
    "DEBIT",
    "HSA_FSA",
    "NON_RELOADABLE_PREPAID",
    "RELOADABLE_PREPAID",
    "UNKNOWN"
  ])

  defenum(Country, [
    "ABW", "AFG", "AGO", "AIA", "ALA", "ALB", "AND", "ARE", "ARG", "ARM",
    "ASM", "ATA", "ATF", "ATG", "AUS", "AUT", "AZE", "BDI", "BEL", "BEN",
    "BES", "BFA", "BGD", "BGR", "BHR", "BHS", "BIH", "BLM", "BLR", "BLZ",
    "BMU", "BOL", "BRA", "BRB", "BRN", "BTN", "BVT", "BWA", "CAF", "CAN",
    "CCK", "CHE", "CHL", "CHN", "CIV", "CMR", "COD", "COG", "COK", "COL",
    "COM", "CPV", "CRI", "CUB", "CUW", "CXR", "CYM", "CYP", "CZE", "DEU",
    "DJI", "DMA", "DNK", "DOM", "DZA", "ECU", "EGY", "ERI", "ESH", "ESP",
    "EST", "ETH", "FIN", "FJI", "FLK", "FRA", "FRO", "FSM", "GAB", "GBR",
    "GEO", "GGY", "GHA", "GIB", "GIN", "GLP", "GMB", "GNB", "GNQ", "GRC",
    "GRD", "GRL", "GTM", "GUF", "GUM", "GUY", "HKG", "HMD", "HND", "HRV",
    "HTI", "HUN", "IDN", "IMN", "IND", "IOT", "IRL", "IRN", "IRQ", "ISL",
    "ISR", "ITA", "JAM", "JEY", "JOR", "JPN", "KAZ", "KEN", "KGZ", "KHM",
    "KIR", "KNA", "KOR", "KWT", "LAO", "LBN", "LBR", "LBY", "LCA", "LIE",
    "LKA", "LSO", "LTU", "LUX", "LVA", "MAC", "MAF", "MAR", "MCO", "MDA",
    "MDG", "MDV", "MEX", "MHL", "MKD", "MLI", "MLT", "MMR", "MNE", "MNG",
    "MNP", "MRT", "MSR", "MTQ", "MUS", "MWI", "MYS", "MYT", "NAM", "NCL",
    "NER", "NFK", "NGA", "NIC", "NIU", "NLD", "NOR", "NPL", "NRU", "NZL",
    "OMN", "PAK", "PAN", "PCN", "PER", "PHL", "PLW", "PNG", "POL", "PRI",
    "PRK", "PRT", "PRY", "PSE", "PYF", "QAT", "REU", "ROU", "RUS", "RWA",
    "SAU", "SDN", "SEN", "SGP", "SGS", "SHN", "SJM", "SLB", "SLE", "SLV",
    "SMR", "SOM", "SPM", "SRB", "SSD", "STP", "SUR", "SVK", "SVN", "SWE",
    "SWZ", "SXM", "SYC", "SYR", "TCA", "TCD", "TGO", "THA", "TJK", "TKL",
    "TKM", "TLS", "TON", "TTO", "TUN", "TUR", "TUV", "TWN", "TZA", "UGA",
    "UKR", "UMI", "URY", "USA", "UZB", "VAT", "VCT", "VEN", "VGB", "VIR",
    "VNM", "VUT", "WLF", "WSM", "XKX", "YEM", "ZAF", "ZMB", "ZWE"
  ])

  defenum(Currency, [
    "AED", "AFN", "ALL", "AMD", "ANG", "AOA", "ARS", "AUD", "AWG", "AZN",
    "BAM", "BBD", "BDT", "BGN", "BHD", "BIF", "BMD", "BND", "BOB", "BOV",
    "BRL", "BSD", "BTN", "BWP", "BYR", "BZD", "CAD", "CDF", "CHE", "CHF",
    "CHW", "CLF", "CLP", "CNY", "COP", "COU", "CRC", "CUC", "CUP", "CVE",
    "CZK", "DJF", "DKK", "DOP", "DZD", "EGP", "ERN", "ETB", "EUR", "FJD",
    "FKP", "GBP", "GEL", "GHS", "GIP", "GMD", "GNF", "GTQ", "GYD", "HKD",
    "HNL", "HRK", "HTG", "HUF", "IDR", "ILS", "INR", "IQD", "IRR", "ISK",
    "JMD", "JOD", "JPY", "KES", "KGS", "KHR", "KMF", "KPW", "KRW", "KWD",
    "KYD", "KZT", "LAK", "LBP", "LKR", "LRD", "LSL", "LTL", "LYD", "MAD",
    "MDL", "MGA", "MKD", "MMK", "MNT", "MOP", "MRO", "MUR", "MVR", "MWK",
    "MXN", "MXV", "MYR", "MZN", "NAD", "NGN", "NIO", "NOK", "NPR", "NZD",
    "OMR", "PAB", "PEN", "PGK", "PHP", "PKR", "PLN", "PYG", "QAR", "RON",
    "RSD", "RUB", "RWF", "SAR", "SBD", "SCR", "SDG", "SEK", "SGD", "SHP",
    "SLL", "SOS", "SRD", "SSP", "STD", "SVC", "SYP", "SZL", "THB", "TJS",
    "TMT", "TND", "TOP", "TRY", "TTD", "TWD", "TZS", "UAH", "UGX", "USD",
    "USN", "UYI", "UYU", "UZS", "VEF", "VND", "VUV", "WST", "XAF", "XAG",
    "XAU", "XBA", "XBB", "XBC", "XBD", "XCD", "XDR", "XOF", "XPD", "XPF",
    "XPT", "XSU", "XTS", "XUA", "XXX", "YER", "ZAR", "ZMW", "ZWL"
  ])

  defenum(ErrorCode, [
    "BAD_REQUEST",
    "UNAUTHORIZED",
    "UPSTREAM_PROCESSOR_ERROR",
    "FORBIDDEN",
    "NOT_FOUND",
    "METHOD_NOT_ALLOWED",
    "NOT_ACCEPTABLE",
    "CONFLICT",
    "UNPROCESSABLE_ENTITY",
    "INTERNAL_SERVER_ERROR"
  ])

  defenum(IdentityRole, [
    "APPLICATION_OWNER",
    "BENEFICIAL_OWNER",
    "BUYER",
    "PLATFORM_OWNER",
    "RECIPIENT",
    "SELLER",
    "SENDER"
  ])

  defenum(IssuerCountry, ["USA", "NON_USA", "UNKNOWN"])

  defenum(PayloadType, ["SOURCE", "DESTINATION"])

  defenum(PaymentInstrumentType, ["TOKEN", "PAYMENT_CARD", "BANK_ACCOUNT"])

  defenum(SecurityCodeVerification, ["MATCHED", "UNKNOWN", "UNMATCHED"])
end
