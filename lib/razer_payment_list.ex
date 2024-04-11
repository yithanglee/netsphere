defmodule Razer.PaymentList do
  def prod_list() do
    [
      %{
        "title" => "Alipay+",
        "status" => 1,
        "currency" => [
          "MYR",
          "SGD",
          "PHP"
        ],
        "channel_type" => "EW",
        "channel_map" => %{
          "hosted" => %{
            "request" => "AlipayPlus",
            "response" => "AlipayPlus"
          },
          "seamless" => %{
            "request" => "AlipayPlus",
            "response" => "AlipayPlus"
          },
          "seamlesspayment" => %{
            "request" => "",
            "response" => "AlipayPlus"
          },
          "direct" => %{
            "request" => "",
            "response" => "ALIPAYPLUS"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/AlipayPlus.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/AlipayPlus.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/AlipayPlus.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/AlipayPlus.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/AlipayPlus.gif"
      },
      %{
        "title" => "AXS",
        "status" => 1,
        "currency" => [
          "SGD"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "AXS",
            "response" => "AXS"
          },
          "seamless" => %{
            "request" => "AXS",
            "response" => "AXS"
          },
          "seamlesspayment" => %{
            "request" => "AXS",
            "response" => "AXS"
          },
          "direct" => %{
            "request" => "AXS",
            "response" => "AXS"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/AXS2-16x16.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/AXS2-24x24.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/AXS2-32x32.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/AXS2-48x48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/AXS2-120x120.gif"
      },
      %{
        "title" => "ธนาคารกรุงศรีอยุธยา",
        "status" => 1,
        "currency" => [
          "THB"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "BAY_IB_U",
            "response" => "BAY_IB_U"
          },
          "seamless" => %{
            "request" => "BAY_IB_U",
            "response" => "BAY_IB_U"
          },
          "seamlesspayment" => %{
            "request" => "BAY_IB_U",
            "response" => "BAY_IB_U"
          },
          "direct" => %{
            "request" => "BAY_IB_U",
            "response" => "BAY_IB_U"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/krungsi.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/krungsi.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/krungsi.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/krungsi.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/krungsri.gif"
      },
      %{
        "title" => "ธนาคารกรุงเทพ (ลูกค้าจ่ายค่าธรรมเนียม)",
        "status" => 1,
        "currency" => [
          "THB"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "BBL_IB_U",
            "response" => "BBL_IB_U"
          },
          "seamless" => %{
            "request" => "BBL_IB_U",
            "response" => "BBL_IB_U"
          },
          "seamlesspayment" => %{
            "request" => "BBL_IB_U",
            "response" => "BBL_IB_U"
          },
          "direct" => %{
            "request" => "BBL_IB_U",
            "response" => "BBL_IB_U"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/bkk.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/bkk.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/bkk.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/bkk.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/bkk.gif"
      },
      %{
        "title" => "Boost",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "EW",
        "channel_map" => %{
          "hosted" => %{
            "request" => "BOOST",
            "response" => "BOOST"
          },
          "seamless" => %{
            "request" => "BOOST",
            "response" => "BOOST"
          },
          "seamlesspayment" => %{
            "request" => "BOOST",
            "response" => "BOOST"
          },
          "direct" => %{
            "request" => "BOOST",
            "response" => "BOOST"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/BOOST_16x16.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/BOOST_24x24.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/BOOST_32x32.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/BOOST_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/BOOST_120x43.gif"
      },
      %{
        "title" => "Cash 7-Eleven",
        "status" => 1,
        "currency" => [
          "MYR"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "cash",
            "response" => "cash"
          },
          "seamless" => %{
            "request" => "cash-711",
            "response" => "cash"
          },
          "seamlesspayment" => %{
            "request" => "cash",
            "response" => "cash"
          },
          "direct" => %{
            "request" => "CASH-711",
            "response" => "cash"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/7e.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/7e.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/7e.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/7e.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/7e.gif"
      },
      %{
        "title" => "SingPost",
        "status" => 1,
        "currency" => [
          "SGD"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "singpost",
            "response" => "Cash-SAM"
          },
          "seamless" => %{
            "request" => "singpost",
            "response" => "Cash-SAM"
          },
          "seamlesspayment" => %{
            "request" => "singpost",
            "response" => "Cash-SAM"
          },
          "direct" => %{
            "request" => "CASH-SAM",
            "response" => "Cash-SAM"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/sampost.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/sampost.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/sampost.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/sampost.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/sampost.gif"
      },
      %{
        "title" => "จ่ายบิลเงินสดผ่านเรเซอร์",
        "status" => 1,
        "currency" => [
          "THB"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "Cash-TH",
            "response" => "Cash-TH"
          },
          "seamless" => %{
            "request" => "Cash-TH",
            "response" => "Cash-TH"
          },
          "seamlesspayment" => %{
            "request" => "Cash-TH",
            "response" => "Cash-TH"
          },
          "direct" => %{
            "request" => "Cash-TH",
            "response" => "Cash-TH"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/razer_cash.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/razer_cash.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/razer_cash.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/razer_cash.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/razer_cash.gif"
      },
      %{
        "title" => "DOKU Alfamart",
        "status" => 1,
        "currency" => [
          "IDR"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DK_ALFA",
            "response" => "DK_ALFA"
          },
          "seamless" => %{
            "request" => "DK_ALFA",
            "response" => "DK_ALFA"
          },
          "seamlesspayment" => %{
            "request" => "DK_ALFA",
            "response" => "DK_ALFA"
          },
          "direct" => %{
            "request" => "DK_ALFA",
            "response" => "DK_ALFA"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/alfa_16.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/alfa_24.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/alfa_32.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/alfa_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/alfa_120.gif"
      },
      %{
        "title" => "DOKU Indomaret",
        "status" => 1,
        "currency" => [
          "IDR"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DK_Indomaret",
            "response" => "DK_Indomaret"
          },
          "seamless" => %{
            "request" => "DK_Indomaret",
            "response" => "DK_Indomaret"
          },
          "seamlesspayment" => %{
            "request" => " ",
            "response" => " "
          },
          "direct" => %{
            "request" => "DK_INDOMARET",
            "response" => "DK_INDOMARET"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/indomaret_16.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/indomaret_24.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/indomaret_32.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/indomaret_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/indomaret_120.gif"
      },
      %{
        "title" => "DOKU Permata VA",
        "status" => 1,
        "currency" => [
          "IDR"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DK_PERMATA_VA",
            "response" => "DK_PERMATA_VA"
          },
          "seamless" => %{
            "request" => "DK_PERMATA_VA",
            "response" => "DK_PERMATA_VA"
          },
          "seamlesspayment" => %{
            "request" => "-",
            "response" => "-"
          },
          "direct" => %{
            "request" => "DK_PERMATA_VA",
            "response" => "DK_PERMATA_VA"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/permata.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/permata.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/permata.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/permata.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/permata.gif"
      },
      %{
        "title" => "AUB Online/Cash Payment",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_AUB",
            "response" => "DP_AUB"
          },
          "seamless" => %{
            "request" => "DP_AUB",
            "response" => "DP_AUB"
          },
          "seamlesspayment" => %{
            "request" => "DP_AUB",
            "response" => "DP_AUB"
          },
          "direct" => %{
            "request" => "DP_AUB",
            "response" => "DP_AUB"
          },
          "offline" => %{
            "request" => "DP_AUB",
            "response" => "DP_AUB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_AUB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_AUB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_AUB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_AUB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_AUB.gif"
      },
      %{
        "title" => "Banco de Oro ATM",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_BDOA",
            "response" => "DP_BDOA"
          },
          "seamless" => %{
            "request" => "DP_BDOA",
            "response" => "DP_BDOA"
          },
          "seamlesspayment" => %{
            "request" => "DP_BDOA",
            "response" => "DP_BDOA"
          },
          "direct" => %{
            "request" => "DP_BDOA",
            "response" => "DP_BDOA"
          },
          "offline" => %{
            "request" => "DP_BDOA",
            "response" => "DP_BDOA"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_BDOA.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_BDOA.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_BDOA.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_BDOA.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_BDOA.gif"
      },
      %{
        "title" => "BDO Cash Deposit",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_BDRX",
            "response" => "DP_BDRX"
          },
          "seamless" => %{
            "request" => "DP_BDRX",
            "response" => "DP_BDRX"
          },
          "seamlesspayment" => %{
            "request" => "DP_BDRX",
            "response" => "DP_BDRX"
          },
          "direct" => %{
            "request" => "DP_BDRX",
            "response" => "DP_BDRX"
          },
          "offline" => %{
            "request" => "DP_BDRX",
            "response" => "DP_BDRX"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_BDRX.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_BDRX.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_BDRX.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_BDRX.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_BDRX.gif"
      },
      %{
        "title" => "BDO Network Bank (formerly ONB) Cash Dep",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_BNRX",
            "response" => "DP_BNRX"
          },
          "seamless" => %{
            "request" => "DP_BNRX",
            "response" => "DP_BNRX"
          },
          "seamlesspayment" => %{
            "request" => "DP_BNRX",
            "response" => "DP_BNRX"
          },
          "direct" => %{
            "request" => "DP_BNRX",
            "response" => "DP_BNRX"
          },
          "offline" => %{
            "request" => "DP_BNRX",
            "response" => "DP_BNRX"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_BNRX.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_BNRX.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_BNRX.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_BNRX.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_BNRX.gif"
      },
      %{
        "title" => "BPI Cash Payment",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_BPXB",
            "response" => "DP_BPXB"
          },
          "seamless" => %{
            "request" => "DP_BPXB",
            "response" => "DP_BPXB"
          },
          "seamlesspayment" => %{
            "request" => "DP_BPXB",
            "response" => "DP_BPXB"
          },
          "direct" => %{
            "request" => "DP_BPXB",
            "response" => "DP_BPXB"
          },
          "offline" => %{
            "request" => "DP_BPXB",
            "response" => "DP_BPXB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_BPXB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_BPXB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_BPXB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_BPXB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_BPXB.gif"
      },
      %{
        "title" => "Chinabank Cash Payment",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_CBXB",
            "response" => "DP_CBXB"
          },
          "seamless" => %{
            "request" => "DP_CBXB",
            "response" => "DP_CBXB"
          },
          "seamlesspayment" => %{
            "request" => "DP_CBXB",
            "response" => "DP_CBXB"
          },
          "direct" => %{
            "request" => "DP_CBXB",
            "response" => "DP_CBXB"
          },
          "offline" => %{
            "request" => "DP_CBXB",
            "response" => "DP_CBXB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_CBXB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_CBXB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_CBXB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_CBXB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_CBXB.gif"
      },
      %{
        "title" => "Cebuana Lhuillier Bills Payment",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_CEBL",
            "response" => "DP_CEBL"
          },
          "seamless" => %{
            "request" => "DP_CEBL",
            "response" => "DP_CEBL"
          },
          "seamlesspayment" => %{
            "request" => "DP_CEBL",
            "response" => "DP_CEBL"
          },
          "direct" => %{
            "request" => "DP_CEBL",
            "response" => "DP_CEBL"
          },
          "offline" => %{
            "request" => "DP_CEBL",
            "response" => "DP_CEBL"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_CEBL.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_CEBL.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_CEBL.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_CEBL.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_CEBL.gif"
      },
      %{
        "title" => "CVM PAWNSHOP",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_CVM",
            "response" => "DP_CVM"
          },
          "seamless" => %{
            "request" => "DP_CVM",
            "response" => "DP_CVM"
          },
          "seamlesspayment" => %{
            "request" => "DP_CVM",
            "response" => "DP_CVM"
          },
          "direct" => %{
            "request" => "DP_CVM",
            "response" => "DP_CVM"
          },
          "offline" => %{
            "request" => "DP_CVM",
            "response" => "DP_CVM"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_CVM.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_CVM.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_CVM.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_CVM.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_CVM.gif"
      },
      %{
        "title" => "ECPay",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_ECPY",
            "response" => "DP_ECPY"
          },
          "seamless" => %{
            "request" => "DP_ECPY",
            "response" => "DP_ECPY"
          },
          "seamlesspayment" => %{
            "request" => "",
            "response" => "DP_ECPY"
          },
          "direct" => %{
            "request" => "DP_ECPY",
            "response" => "DP_ECPY"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_ECPY_16.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_ECPY_24.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_ECPY_32.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_ECPY_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_ECPY_120.gif"
      },
      %{
        "title" => "EastWest Online/Cash Payment",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_EWXB",
            "response" => "DP_EWXB"
          },
          "seamless" => %{
            "request" => "DP_EWXB",
            "response" => "DP_EWXB"
          },
          "seamlesspayment" => %{
            "request" => "DP_EWXB",
            "response" => "DP_EWXB"
          },
          "direct" => %{
            "request" => "DP_EWXB",
            "response" => "DP_EWXB"
          },
          "offline" => %{
            "request" => "DP_EWXB",
            "response" => "DP_EWXB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_EWXB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_EWXB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_EWXB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_EWXB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_EWXB.gif"
      },
      %{
        "title" => "Globe GCash via dpc",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_GCSH",
            "response" => "DP_GCSH"
          },
          "seamless" => %{
            "request" => "",
            "response" => "DP_GCSH"
          },
          "seamlesspayment" => %{
            "request" => "",
            "response" => "DP_GCSH"
          },
          "direct" => %{
            "request" => "DP_GCSH",
            "response" => "DP_GCSH"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_GCSH_16.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_GCSH_24.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_GCSH_32.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_GCSH_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_GCSH_120.gif"
      },
      %{
        "title" => "i2i Rural Banks",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_I2I",
            "response" => "DP_I2I"
          },
          "seamless" => %{
            "request" => "DP_I2I",
            "response" => "DP_I2I"
          },
          "seamlesspayment" => %{
            "request" => "DP_I2I",
            "response" => "DP_I2I"
          },
          "direct" => %{
            "request" => "DP_I2I",
            "response" => "DP_I2I"
          },
          "offline" => %{
            "request" => "DP_I2I",
            "response" => "DP_I2I"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_I2I.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_I2I.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_I2I.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_I2I.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_I2I.gif"
      },
      %{
        "title" => "Landbank Cash Payment",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_LBXB",
            "response" => "DP_LBXB"
          },
          "seamless" => %{
            "request" => "DP_LBXB",
            "response" => "DP_LBXB"
          },
          "seamlesspayment" => %{
            "request" => "DP_LBXB",
            "response" => "DP_LBXB"
          },
          "direct" => %{
            "request" => "DP_LBXB",
            "response" => "DP_LBXB"
          },
          "offline" => %{
            "request" => "DP_LBXB",
            "response" => "DP_LBXB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_LBXB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_LBXB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_LBXB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_LBXB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_LBXB.gif"
      },
      %{
        "title" => "Metrobank Cash Payment",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_MBXB",
            "response" => "DP_MBXB"
          },
          "seamless" => %{
            "request" => "DP_MBXB",
            "response" => "DP_MBXB"
          },
          "seamlesspayment" => %{
            "request" => "DP_MBXB",
            "response" => "DP_MBXB"
          },
          "direct" => %{
            "request" => "DP_MBXB",
            "response" => "DP_MBXB"
          },
          "offline" => %{
            "request" => "DP_MBXB",
            "response" => "DP_MBXB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_MBTC.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_MBXB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_MBXB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_MBXB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_MBXB.gif"
      },
      %{
        "title" => "M Lhuiller",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_MLH",
            "response" => "DP_MLH"
          },
          "seamless" => %{
            "request" => "",
            "response" => "DP_MLH"
          },
          "seamlesspayment" => %{
            "request" => "",
            "response" => "DP_MLH"
          },
          "direct" => %{
            "request" => "DP_MLH",
            "response" => "DP_MLH"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_MLH_16.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_MLH_24.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_MLH_32.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_MLH_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_MLH_120.gif"
      },
      %{
        "title" => "Palawan Pawnshop",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_PLWN",
            "response" => "DP_PLWN"
          },
          "seamless" => %{
            "request" => "DP_PLWN",
            "response" => "DP_PLWN"
          },
          "seamlesspayment" => %{
            "request" => "DP_PLWN",
            "response" => "DP_PLWN"
          },
          "direct" => %{
            "request" => "DP_PLWN",
            "response" => "DP_PLWN"
          },
          "offline" => %{
            "request" => "DP_PLWN",
            "response" => "DP_PLWN"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_PLWN.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_PLWN.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_PLWN.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_PLWN.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_PLWN.gif"
      },
      %{
        "title" => "PNB Internet Banking Bills Payment",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_PNBB",
            "response" => "DP_PNBB"
          },
          "seamless" => %{
            "request" => "DP_PNBB",
            "response" => "DP_PNBB"
          },
          "seamlesspayment" => %{
            "request" => "DP_PNBB",
            "response" => "DP_PNBB"
          },
          "direct" => %{
            "request" => "DP_PNBB",
            "response" => "DP_PNBB"
          },
          "offline" => %{
            "request" => "DP_PNBB",
            "response" => "DP_PNBB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_PNBB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_PNBB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_PNBB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_PNBB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_PNBB.gif"
      },
      %{
        "title" => "PNB Cash Payment",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_PNXB",
            "response" => "DP_PNXB"
          },
          "seamless" => %{
            "request" => "DP_PNXB",
            "response" => "DP_PNXB"
          },
          "seamlesspayment" => %{
            "request" => "DP_PNXB",
            "response" => "DP_PNXB"
          },
          "direct" => %{
            "request" => "DP_PNXB",
            "response" => "DP_PNXB"
          },
          "offline" => %{
            "request" => "DP_PNXB",
            "response" => "DP_PNXB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_PNXB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_PNXB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_PNXB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_PNXB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_PNXB.gif"
      },
      %{
        "title" => "POSIBLE.NET",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_POSB",
            "response" => "DP_POSB"
          },
          "seamless" => %{
            "request" => "DP_POSB",
            "response" => "DP_POSB"
          },
          "seamlesspayment" => %{
            "request" => "DP_POSB",
            "response" => "DP_POSB"
          },
          "direct" => %{
            "request" => "DP_POSB",
            "response" => "DP_POSB"
          },
          "offline" => %{
            "request" => "DP_POSB",
            "response" => "DP_POSB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_POSB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_POSB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_POSB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_POSB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_POSB.gif"
      },
      %{
        "title" => "PERAHUB",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_PRHB",
            "response" => "DP_PRHB"
          },
          "seamless" => %{
            "request" => "DP_PRHB",
            "response" => "DP_PRHB"
          },
          "seamlesspayment" => %{
            "request" => "DP_PRHB",
            "response" => "DP_PRHB"
          },
          "direct" => %{
            "request" => "DP_PRHB",
            "response" => "DP_PRHB"
          },
          "offline" => %{
            "request" => "DP_PRHB",
            "response" => "DP_PRHB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_PRHB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_PRHB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_PRHB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_PRHB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_PRHB.gif"
      },
      %{
        "title" => "RCBC Cash Payment / ATM Bills Payment",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_RCXB",
            "response" => "DP_RCXB"
          },
          "seamless" => %{
            "request" => "DP_RCXB",
            "response" => "DP_RCXB"
          },
          "seamlesspayment" => %{
            "request" => "DP_RCXB",
            "response" => "DP_RCXB"
          },
          "direct" => %{
            "request" => "DP_RCXB",
            "response" => "DP_RCXB"
          },
          "offline" => %{
            "request" => "DP_RCXB",
            "response" => "DP_RCXB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_RCXB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_RCXB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_RCXB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_RCXB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_RCXB.gif"
      },
      %{
        "title" => "RD Pawnshop",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_RDP",
            "response" => "DP_RDP"
          },
          "seamless" => %{
            "request" => "DP_RDP",
            "response" => "DP_RDP"
          },
          "seamlesspayment" => %{
            "request" => "DP_RDP",
            "response" => "DP_RDP"
          },
          "direct" => %{
            "request" => "DP_RDP",
            "response" => "DP_RDP"
          },
          "offline" => %{
            "request" => "DP_RDP",
            "response" => "DP_RDP"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_RDP.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_RDP.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_RDP.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_RDP.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_RDP.gif"
      },
      %{
        "title" => "Robinsons Dept Store",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_RDS",
            "response" => "DP_RDS"
          },
          "seamless" => %{
            "request" => "",
            "response" => "DP_RDS"
          },
          "seamlesspayment" => %{
            "request" => "",
            "response" => "DP_RDS"
          },
          "direct" => %{
            "request" => "DP_RDS",
            "response" => "DP_RDS"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_RDS_16.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_RDS_24.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_RDS_32.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_RDS_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_RDS_120.gif"
      },
      %{
        "title" => "RuralNet Banks and Coops",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_RLNT",
            "response" => "DP_RLNT"
          },
          "seamless" => %{
            "request" => "DP_RLNT",
            "response" => "DP_RLNT"
          },
          "seamlesspayment" => %{
            "request" => "DP_RLNT",
            "response" => "DP_RLNT"
          },
          "direct" => %{
            "request" => "DP_RLNT",
            "response" => "DP_RLNT"
          },
          "offline" => %{
            "request" => "DP_RLNT",
            "response" => "DP_RLNT"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_RLNT.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_RLNT.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_RLNT.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_RLNT.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_RLNT.gif"
      },
      %{
        "title" => "RobinsonsBank Cash Payment",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_RSBB",
            "response" => "DP_RSBB"
          },
          "seamless" => %{
            "request" => "DP_RSBB",
            "response" => "DP_RSBB"
          },
          "seamlesspayment" => %{
            "request" => "DP_RSBB",
            "response" => "DP_RSBB"
          },
          "direct" => %{
            "request" => "DP_RSBB",
            "response" => "DP_RSBB"
          },
          "offline" => %{
            "request" => "DP_RSBB",
            "response" => "DP_RSBB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_RSBB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_RSBB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_RSBB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_RSBB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_RSBB.gif"
      },
      %{
        "title" => "Security Bank Cash Payment",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_SBCB",
            "response" => "DP_SBCB"
          },
          "seamless" => %{
            "request" => "DP_SBCB",
            "response" => "DP_SBCB"
          },
          "seamlesspayment" => %{
            "request" => "DP_SBCB",
            "response" => "DP_SBCB"
          },
          "direct" => %{
            "request" => "DP_SBCB",
            "response" => "DP_SBCB"
          },
          "offline" => %{
            "request" => "DP_SBCB",
            "response" => "DP_SBCB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_SBCB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_SBCB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_SBCB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_SBCB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_SBCB.gif"
      },
      %{
        "title" => "SM Retail",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_SMR",
            "response" => "DP_SMR"
          },
          "seamless" => %{
            "request" => "",
            "response" => "DP_SMR"
          },
          "seamlesspayment" => %{
            "request" => "",
            "response" => "DP_SMR"
          },
          "direct" => %{
            "request" => "DP_SMR",
            "response" => "DP_SMR"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_SMR_16.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_SMR_24.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_SMR_32.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_SMR_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_SMR_120.gif"
      },
      %{
        "title" => "Unionbank Cash Payment",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_UBXB",
            "response" => "DP_UBXB"
          },
          "seamless" => %{
            "request" => "DP_UBXB",
            "response" => "DP_UBXB"
          },
          "seamlesspayment" => %{
            "request" => "DP_UBXB",
            "response" => "DP_UBXB"
          },
          "direct" => %{
            "request" => "DP_UBXB",
            "response" => "DP_UBXB"
          },
          "offline" => %{
            "request" => "DP_UBXB",
            "response" => "DP_UBXB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_UBXB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_UBXB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_UBXB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_UBXB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_UBXB.gif"
      },
      %{
        "title" => "UCPB ATM/Cash Payment",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_UCXB",
            "response" => "DP_UCXB"
          },
          "seamless" => %{
            "request" => "DP_UCXB",
            "response" => "DP_UCXB"
          },
          "seamlesspayment" => %{
            "request" => "DP_UCXB",
            "response" => "DP_UCXB"
          },
          "direct" => %{
            "request" => "DP_UCXB",
            "response" => "DP_UCXB"
          },
          "offline" => %{
            "request" => "DP_UCXB",
            "response" => "DP_UCXB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_UCXB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_UCXB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_UCXB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_UCXB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_UCXB.gif"
      },
      %{
        "title" => "USSC",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "OTC",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_USSC",
            "response" => "DP_USSC"
          },
          "seamless" => %{
            "request" => "DP_USSC",
            "response" => "DP_USSC"
          },
          "seamlesspayment" => %{
            "request" => "DP_USSC",
            "response" => "DP_USSC"
          },
          "direct" => %{
            "request" => "DP_USSC",
            "response" => "DP_USSC"
          },
          "offline" => %{
            "request" => "DP_USSC",
            "response" => "DP_USSC"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_USSC.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_USSC.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_USSC.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_USSC.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_USSC.gif"
      },
      %{
        "title" => "Dragonpay",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "dragonpay",
            "response" => "dragonpay"
          },
          "seamless" => %{
            "request" => "dragonpay",
            "response" => "dragonpay"
          },
          "seamlesspayment" => %{
            "request" => "dragonpay",
            "response" => "dragonpay"
          },
          "direct" => %{
            "request" => "DRAGONPAY",
            "response" => "DRAGONPAY"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/dragonpay.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/dragonpay.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/dragonpay.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/dragonpay.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/dragonpay.gif"
      },
      %{
        "title" => "BDO Internet Banking",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_BDO",
            "response" => "DP_BDO"
          },
          "seamless" => %{
            "request" => "DP_BDO",
            "response" => "DP_BDO"
          },
          "seamlesspayment" => %{
            "request" => "DP_BDO",
            "response" => "DP_BDO"
          },
          "direct" => %{
            "request" => "DP_BDO",
            "response" => "DP_BDO"
          },
          "offline" => %{
            "request" => "DP_BDO",
            "response" => "DP_BDO"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_BDO.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_BDO.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_BDO.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_BDO.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_BDO.gif"
      },
      %{
        "title" => "Bank of Commerce Online",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_BOC",
            "response" => "DP_BOC"
          },
          "seamless" => %{
            "request" => "DP_BOC",
            "response" => "DP_BOC"
          },
          "seamlesspayment" => %{
            "request" => "DP_BOC",
            "response" => "DP_BOC"
          },
          "direct" => %{
            "request" => "DP_BOC",
            "response" => "DP_BOC"
          },
          "offline" => %{
            "request" => "DP_BOC",
            "response" => "DP_BOC"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_BOC.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_BOC.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_BOC.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_BOC.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_BOC.gif"
      },
      %{
        "title" => "BPI Online",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_BPIA",
            "response" => "DP_BPIA"
          },
          "seamless" => %{
            "request" => "DP_BPIA",
            "response" => "DP_BPIA"
          },
          "seamlesspayment" => %{
            "request" => "DP_BPIA",
            "response" => "DP_BPIA"
          },
          "direct" => %{
            "request" => "DP_BPIA",
            "response" => "DP_BPIA"
          },
          "offline" => %{
            "request" => "DP_BPIA",
            "response" => "DP_BPIA"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_BPIA.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_BPIA.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_BPIA.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_BPIA.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_BPIA.gif"
      },
      %{
        "title" => "Chinabank Online Bills Payment",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_CBCB",
            "response" => "DP_CBCB"
          },
          "seamless" => %{
            "request" => "DP_CBCB",
            "response" => "DP_CBCB"
          },
          "seamlesspayment" => %{
            "request" => "DP_CBCB",
            "response" => "DP_CBCB"
          },
          "direct" => %{
            "request" => "DP_CBCB",
            "response" => "DP_CBCB"
          },
          "offline" => %{
            "request" => "DP_CBCB",
            "response" => "DP_CBCB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_CBCB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_CBCB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_CBCB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_CBCB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_CBCB.gif"
      },
      %{
        "title" => "UnionPay via dpc",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_CUP",
            "response" => "DP_CUP"
          },
          "seamless" => %{
            "request" => "",
            "response" => "DP_CUP"
          },
          "seamlesspayment" => %{
            "request" => "",
            "response" => "DP_CUP"
          },
          "direct" => %{
            "request" => "DP_CUP",
            "response" => "DP_CUP"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_CUP_16.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_CUP_24.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_CUP_32.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_CUP_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_CUP_120.gif"
      },
      %{
        "title" => "Landbank ATM Online",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_LBPA",
            "response" => "DP_LBPA"
          },
          "seamless" => %{
            "request" => "DP_LBPA",
            "response" => "DP_LBPA"
          },
          "seamlesspayment" => %{
            "request" => "DP_LBPA",
            "response" => "DP_LBPA"
          },
          "direct" => %{
            "request" => "DP_LBPA",
            "response" => "DP_LBPA"
          },
          "offline" => %{
            "request" => "DP_LBPA",
            "response" => "DP_LBPA"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_LBPA.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_LBPA.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_LBPA.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_LBPA.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_LBPA.gif"
      },
      %{
        "title" => "Maybank Online Banking",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_MAYB",
            "response" => "DP_MAYB"
          },
          "seamless" => %{
            "request" => "DP_MAYB",
            "response" => "DP_MAYB"
          },
          "seamlesspayment" => %{
            "request" => "DP_MAYB",
            "response" => "DP_MAYB"
          },
          "direct" => %{
            "request" => "DP_MAYB",
            "response" => "DP_MAYB"
          },
          "offline" => %{
            "request" => "DP_MAYB",
            "response" => "DP_MAYB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DB_MAYB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DB_MAYB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_MAYB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_MAYB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_MAYB.gif"
      },
      %{
        "title" => "Metrobank Online Banking",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_MBTC",
            "response" => "DP_MBTC"
          },
          "seamless" => %{
            "request" => "DP_MBTC",
            "response" => "DP_MBTC"
          },
          "seamlesspayment" => %{
            "request" => "DP_MBTC",
            "response" => "DP_MBTC"
          },
          "direct" => %{
            "request" => "DP_MBTC",
            "response" => "DP_MBTC"
          },
          "offline" => %{
            "request" => "DP_MBTC",
            "response" => "DP_MBTC"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_MBTC.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_MBTC.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_MBTC.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_MBTC.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_MBTC.gif"
      },
      %{
        "title" => "PSBank Online",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_PSB",
            "response" => "DP_PSB"
          },
          "seamless" => %{
            "request" => "DP_PSB",
            "response" => "DP_PSB"
          },
          "seamlesspayment" => %{
            "request" => "DP_PSB",
            "response" => "DP_PSB"
          },
          "direct" => %{
            "request" => "DP_PSB",
            "response" => "DP_PSB"
          },
          "offline" => %{
            "request" => "DP_PSB",
            "response" => "DP_PSB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_PSB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_PSB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_PSB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_PSB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_PSB.gif"
      },
      %{
        "title" => "RCBC Online Banking",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_RCBC",
            "response" => "DP_RCBC"
          },
          "seamless" => %{
            "request" => "DP_RCBC",
            "response" => "DP_RCBC"
          },
          "seamlesspayment" => %{
            "request" => "DP_RCBC",
            "response" => "DP_RCBC"
          },
          "direct" => %{
            "request" => "DP_RCBC",
            "response" => "DP_RCBC"
          },
          "offline" => %{
            "request" => "DP_RCBC",
            "response" => "DP_RCBC"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_RCBC.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_RCBC.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_RCBC.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_RCBC.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_RCBC.gif"
      },
      %{
        "title" => "RobinsonsBank Online Bills Payment",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_RSB",
            "response" => "DP_RSB"
          },
          "seamless" => %{
            "request" => "DP_RSB",
            "response" => "DP_RSB"
          },
          "seamlesspayment" => %{
            "request" => "DP_RSB",
            "response" => "DP_RSB"
          },
          "direct" => %{
            "request" => "DP_RSB",
            "response" => "DP_RSB"
          },
          "offline" => %{
            "request" => "DP_RSB",
            "response" => "DP_RSB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_RSB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DB_RSB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_RSB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_RSB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_RSB.gif"
      },
      %{
        "title" => "Unionbank Internet Banking",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "DP_UBPB",
            "response" => "DP_UBPB"
          },
          "seamless" => %{
            "request" => "DP_UBPB",
            "response" => "DP_UBPB"
          },
          "seamlesspayment" => %{
            "request" => "DP_UBPB",
            "response" => "DP_UBPB"
          },
          "direct" => %{
            "request" => "DP_UBPB",
            "response" => "DP_UBPB"
          },
          "offline" => %{
            "request" => "DP_UBPB",
            "response" => "DP_UBPB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/DP_UBPB.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/DP_UBPB.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/DP_UBPB.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/DP_UBPB.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/DP_UBPB.gif"
      },
      %{
        "title" => "FPX",
        "status" => 1,
        "currency" => [
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX",
            "response" => "fpx"
          },
          "seamless" => %{
            "request" => "fpx",
            "response" => "fpx"
          },
          "seamlesspayment" => %{
            "request" => "FPX",
            "response" => "FPX"
          },
          "direct" => %{
            "request" => "FPX",
            "response" => "FPX"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/fpx.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/fpx.gif"
      },
      %{
        "title" => "Affin Bank (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_ABB",
            "response" => "abb"
          },
          "seamless" => %{
            "request" => "fpx_abb",
            "response" => "abb"
          },
          "seamlesspayment" => %{
            "request" => "fpx_abb",
            "response" => "fpx_abb"
          },
          "direct" => %{
            "request" => "FPX_ABB",
            "response" => "FPX_ABB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_ABB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_ABB_120.gif"
      },
      %{
        "title" => "Alliance Bank Malaysia Berhad (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_ABMB",
            "response" => "alliancebank"
          },
          "seamless" => %{
            "request" => "fpx_abmb",
            "response" => "alliancebank"
          },
          "seamlesspayment" => %{
            "request" => "fpx_abmb",
            "response" => "fpx_abmb"
          },
          "direct" => %{
            "request" => "FPX_ABMB",
            "response" => "FPX_ABMB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_ABMB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_ABMB_120.gif"
      },
      %{
        "title" => "Agrobank (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_AGROBANK",
            "response" => "agrobank"
          },
          "seamless" => %{
            "request" => "fpx_agrobank",
            "response" => "agrobank"
          },
          "seamlesspayment" => %{
            "request" => "fpx_agrobank",
            "response" => "fpx_agrobank"
          },
          "direct" => %{
            "request" => "FPX_AGROBANK",
            "response" => "FPX_AGROBANK"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/fpx.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_AGROBANK_120.gif"
      },
      %{
        "title" => "AmOnline (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "AMOnline",
            "response" => "amb"
          },
          "seamless" => %{
            "request" => "amb",
            "response" => "amb"
          },
          "seamlesspayment" => %{
            "request" => "fpx_amb",
            "response" => "amb"
          },
          "direct" => %{
            "request" => "FPX_AMB",
            "response" => "FPX_AMB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_AMB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_AMB_120.gif"
      },
      %{
        "title" => "Bank Islam (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "BIMB",
            "response" => "bankislam"
          },
          "seamless" => %{
            "request" => "fpx_bimb",
            "response" => "bankislam"
          },
          "seamlesspayment" => %{
            "request" => "fpx_bimb",
            "response" => "bankislam"
          },
          "direct" => %{
            "request" => "FPX_BIMB",
            "response" => "FPX_BIMB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_BIMB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_BIMB_120.gif"
      },
      %{
        "title" => "Bank Kerjasama Rakyat Malaysia (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "bankrakyat",
            "response" => "bkrm"
          },
          "seamless" => %{
            "request" => "fpx_bkrm",
            "response" => "bkrm"
          },
          "seamlesspayment" => %{
            "request" => "fpx_bkrm",
            "response" => "fpx_bkrm"
          },
          "direct" => %{
            "request" => "FPX_BKRM",
            "response" => "FPX_BKRM"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_BKRM_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_BKRM120.gif"
      },
      %{
        "title" => "Bank Muamalat (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "bankmuamalat",
            "response" => "muamalat"
          },
          "seamless" => %{
            "request" => "fpx_bmmb",
            "response" => "muamalat"
          },
          "seamlesspayment" => %{
            "request" => "fpx_bmmb",
            "response" => "fpx_bmmb"
          },
          "direct" => %{
            "request" => "FPX_BMMB",
            "response" => "FPX_BMMB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_BMMB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_BMMB_120.gif"
      },
      %{
        "title" => "Bank of China (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_BOCM",
            "response" => "bocm"
          },
          "seamless" => %{
            "request" => "fpx_bocm",
            "response" => "bocm"
          },
          "seamlesspayment" => %{
            "request" => "fpx_bocm",
            "response" => "fpx_bocm"
          },
          "direct" => %{
            "request" => "FPX_BOCM",
            "response" => "FPX_BOCM"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_BOCM_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_BOCM_120.gif"
      },
      %{
        "title" => "Bank Simpanan Nasional (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_BSN",
            "response" => "bsn"
          },
          "seamless" => %{
            "request" => "fpx_bsn",
            "response" => "bsn"
          },
          "seamlesspayment" => %{
            "request" => "fpx_bsn",
            "response" => "fpx_bsn"
          },
          "direct" => %{
            "request" => "FPX_BSN",
            "response" => "FPX_BSN"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_BSN_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_BSN_120.gif"
      },
      %{
        "title" => "CIMB Clicks (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "CIMBCLICKS",
            "response" => "cimb"
          },
          "seamless" => %{
            "request" => "fpx_cimbclicks",
            "response" => "cimb"
          },
          "seamlesspayment" => %{
            "request" => "fpx_cimbclicks",
            "response" => "cimb"
          },
          "direct" => %{
            "request" => "FPX_CIMBCLICKS",
            "response" => "FPX_CIMBCLICKS"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_CIMBCLICKS_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_CIMBCLICKS_120.gif"
      },
      %{
        "title" => "Hong Leong Online (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "HLBConnect",
            "response" => "hlb"
          },
          "seamless" => %{
            "request" => "fpx_hlb",
            "response" => "hlb"
          },
          "seamlesspayment" => %{
            "request" => "fpx_hlb",
            "response" => "hlb"
          },
          "direct" => %{
            "request" => "FPX_HLB",
            "response" => "FPX_HLB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_HLB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_HLB_120.gif"
      },
      %{
        "title" => "HSBC (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_HSBC",
            "response" => "hsbc"
          },
          "seamless" => %{
            "request" => "fpx_hsbc",
            "response" => "hsbc"
          },
          "seamlesspayment" => %{
            "request" => "fpx_hsbc",
            "response" => "fpx_hsbc"
          },
          "direct" => %{
            "request" => "FPX_HSBC",
            "response" => "FPX_HSBC"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_HSBC_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_HSBC_120.gif"
      },
      %{
        "title" => "Kuwait Finance House (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_KFH",
            "response" => "kuwait-finace"
          },
          "seamless" => %{
            "request" => "fpx_kfh",
            "response" => "kuwait-finace"
          },
          "seamlesspayment" => %{
            "request" => "fpx_kfh",
            "response" => "fpx_kfh"
          },
          "direct" => %{
            "request" => "FPX_KFH",
            "response" => "FPX_KFH"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_KFH_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_KFH_120.gif"
      },
      %{
        "title" => "Maybank2U (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "MB2U",
            "response" => "maybank2u"
          },
          "seamless" => %{
            "request" => "fpx_mb2u",
            "response" => "maybank2u"
          },
          "seamlesspayment" => %{
            "request" => "fpx_mb2u",
            "response" => "maybank2u"
          },
          "direct" => %{
            "request" => "FPX_MB2U",
            "response" => "FPX_MB2U"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_MB2U_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_MB2U_120.gif"
      },
      %{
        "title" => "OCBC Bank (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_OCBC",
            "response" => "ocbc"
          },
          "seamless" => %{
            "request" => "fpx_ocbc",
            "response" => "ocbc"
          },
          "seamlesspayment" => %{
            "request" => "fpx_ocbc",
            "response" => "fpx_ocbc"
          },
          "direct" => %{
            "request" => "FPX_OCBC",
            "response" => "FPX_OCBC"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_OCBC_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_OCBC_120.gif"
      },
      %{
        "title" => "Public Bank (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_PBB",
            "response" => "publicbank"
          },
          "seamless" => %{
            "request" => "fpx_pbb",
            "response" => "publicbank"
          },
          "seamlesspayment" => %{
            "request" => "fpx_pbb",
            "response" => "publicbank"
          },
          "direct" => %{
            "request" => "FPX_PBB",
            "response" => "FPX_PBB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_PBB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_PBB_120.gif"
      },
      %{
        "title" => "RHB Now (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "RHBNow",
            "response" => "rhb"
          },
          "seamless" => %{
            "request" => "fpx_rhb",
            "response" => "rhb"
          },
          "seamlesspayment" => %{
            "request" => "fpx_rhb",
            "response" => "rhb"
          },
          "direct" => %{
            "request" => "FPX_RHB",
            "response" => "FPX_RHB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_RHB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_RHB_120.gif"
      },
      %{
        "title" => "Standard Chartered Bank (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_SCB",
            "response" => "scb"
          },
          "seamless" => %{
            "request" => "fpx_scb",
            "response" => "scb"
          },
          "seamlesspayment" => %{
            "request" => "fpx_scb",
            "response" => "fpx_scb"
          },
          "direct" => %{
            "request" => "FPX_SCB",
            "response" => "FPX_SCB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_SCB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_SCB_120.gif"
      },
      %{
        "title" => "United Oversea Bank (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_UOB",
            "response" => "uob"
          },
          "seamless" => %{
            "request" => "fpx_uob",
            "response" => "uob"
          },
          "seamlesspayment" => %{
            "request" => "fpx_uob",
            "response" => "fpx_uob"
          },
          "direct" => %{
            "request" => "FPX_UOB",
            "response" => "FPX_UOB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_UOB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_UOB_120.gif"
      },
      %{
        "title" => "FPX B2B Model",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B",
            "response" => "FPX_B2B"
          },
          "seamless" => %{
            "request" => "FPX_B2B",
            "response" => "FPX_B2B"
          },
          "seamlesspayment" => %{
            "request" => "",
            "response" => "FPX_B2B"
          },
          "direct" => %{
            "request" => "FPX_B2B",
            "response" => "FPX_B2B"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/fpx-B2B.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/fpx-B2B.gif"
      },
      %{
        "title" => "AffinMax B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_ABBM",
            "response" => "FPX_B2B_ABBM"
          },
          "seamless" => %{
            "request" => "FPX_B2B_ABBM",
            "response" => "FPX_B2B_ABBM"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_ABBM",
            "response" => "FPX_B2B_ABBM"
          },
          "direct" => %{
            "request" => "FPX_B2B_ABBM",
            "response" => "FPX_B2B_ABBM"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_ABBM_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_ABBM_120.gif"
      },
      %{
        "title" => "Alliance Bank B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_ABMB",
            "response" => "FPX_B2B_ABMB"
          },
          "seamless" => %{
            "request" => "FPX_B2B_ABMB",
            "response" => "FPX_B2B_ABMB"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_ABMB",
            "response" => "FPX_B2B_ABMB"
          },
          "direct" => %{
            "request" => "FPX_B2B_ABMB",
            "response" => "FPX_B2B_ABMB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_ABMB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_ABMB_120.gif"
      },
      %{
        "title" => "Agrobank B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_AGROBANK",
            "response" => "FPX_B2B_AGROBANK"
          },
          "seamless" => %{
            "request" => "FPX_B2B_AGROBANK",
            "response" => "FPX_B2B_AGROBANK"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_AGROBANK",
            "response" => "FPX_B2B_AGROBANK"
          },
          "direct" => %{
            "request" => "FPX_B2B_AGROBANK",
            "response" => "FPX_B2B_AGROBANK"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/fpx.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/fpx.gif"
      },
      %{
        "title" => "AmBank B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_AMB",
            "response" => "FPX_B2B_AMB"
          },
          "seamless" => %{
            "request" => "FPX_B2B_AMB",
            "response" => "FPX_B2B_AMB"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_AMB",
            "response" => "FPX_B2B_AMB"
          },
          "direct" => %{
            "request" => "FPX_B2B_AMB",
            "response" => "FPX_B2B_AMB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_AMB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_AMB_120.gif"
      },
      %{
        "title" => "Bank Islam Malaysia Berhad B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_BIMB",
            "response" => "FPX_B2B_BIMB"
          },
          "seamless" => %{
            "request" => "FPX_B2B_BIMB",
            "response" => "FPX_B2B_BIMB"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_BIMB",
            "response" => "FPX_B2B_BIMB"
          },
          "direct" => %{
            "request" => "FPX_B2B_BIMB",
            "response" => "FPX_B2B_BIMB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_BIMB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_BIMB_120.gif"
      },
      %{
        "title" => "i-bizRAKYAT B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_BKRM",
            "response" => "FPX_B2B_BKRM"
          },
          "seamless" => %{
            "request" => "FPX_B2B_BKRM",
            "response" => "FPX_B2B_BKRM"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_BKRM",
            "response" => "FPX_B2B_BKRM"
          },
          "direct" => %{
            "request" => "FPX_B2B_BKRM",
            "response" => "FPX_B2B_BKRM"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_BKRM_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_BKRM_120.gif"
      },
      %{
        "title" => "Bank Muamalat B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_BMMB",
            "response" => "FPX_B2B_BMMB"
          },
          "seamless" => %{
            "request" => "FPX_B2B_BMMB",
            "response" => "FPX_B2B_BMMB"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_BMMB",
            "response" => "FPX_B2B_BMMB"
          },
          "direct" => %{
            "request" => "FPX_B2B_BMMB",
            "response" => "FPX_B2B_BMMB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_BMMB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_BMMB_120.gif"
      },
      %{
        "title" => "BNP Paribas B2B (FPX)",
        "status" => 0,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_BNP",
            "response" => "FPX_B2B_BNP"
          },
          "seamless" => %{
            "request" => "FPX_B2B_BNP",
            "response" => "FPX_B2B_BNP"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_BNP",
            "response" => "FPX_B2B_BNP"
          },
          "direct" => %{
            "request" => "FPX_B2B_BNP",
            "response" => "FPX_B2B_BNP"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_BNP_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_BNP_120.gif"
      },
      %{
        "title" => "BizChannel@CIMB B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_CIMB",
            "response" => "FPX_B2B_CIMB"
          },
          "seamless" => %{
            "request" => "FPX_B2B_CIMB",
            "response" => "FPX_B2B_CIMB"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_CIMB",
            "response" => "FPX_B2B_CIMB"
          },
          "direct" => %{
            "request" => "FPX_B2B_CIMB",
            "response" => "FPX_B2B_CIMB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_CIMB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_CIMB_120.gif"
      },
      %{
        "title" => "Citibank B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_CITIBANK",
            "response" => "FPX_B2B_CITIBANK"
          },
          "seamless" => %{
            "request" => "FPX_B2B_CITIBANK",
            "response" => "FPX_B2B_CITIBANK"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_CITIBANK",
            "response" => "FPX_B2B_CITIBANK"
          },
          "direct" => %{
            "request" => "FPX_B2B_CITIBANK",
            "response" => "FPX_B2B_CITIBANK"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_CITIBANK_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_CITIBANK_120.gif"
      },
      %{
        "title" => "Deutsche Bank B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_DEUTSCHE",
            "response" => "FPX_B2B_DEUTSCHE"
          },
          "seamless" => %{
            "request" => "FPX_B2B_DEUTSCHE",
            "response" => "FPX_B2B_DEUTSCHE"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_DEUTSCHE",
            "response" => "FPX_B2B_DEUTSCHE"
          },
          "direct" => %{
            "request" => "FPX_B2B_DEUTSCHE",
            "response" => "FPX_B2B_DEUTSCHE"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_DEUTSCHE_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_DEUTSCHE_120.gif"
      },
      %{
        "title" => "HongLeong Connect B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_HLB",
            "response" => "FPX_B2B_HLB"
          },
          "seamless" => %{
            "request" => "FPX_B2B_HLB",
            "response" => "FPX_B2B_HLB"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_HLB",
            "response" => "FPX_B2B_HLB"
          },
          "direct" => %{
            "request" => "FPX_B2B_HLB",
            "response" => "FPX_B2B_HLB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_HLB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_HLB_120.gif"
      },
      %{
        "title" => "HSBC B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_HSBC",
            "response" => "FPX_B2B_HSBC"
          },
          "seamless" => %{
            "request" => "FPX_B2B_HSBC",
            "response" => "FPX_B2B_HSBC"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_HSBC",
            "response" => "FPX_B2B_HSBC"
          },
          "direct" => %{
            "request" => "FPX_B2B_HSBC",
            "response" => "FPX_B2B_HSBC"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_HSBC_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_HSBC_120.gif"
      },
      %{
        "title" => "Kuwait Finance House Overseas Bank B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_KFH",
            "response" => "FPX_B2B_KFH"
          },
          "seamless" => %{
            "request" => "FPX_B2B_KFH",
            "response" => "FPX_B2B_KFH"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_KFH",
            "response" => "FPX_B2B_KFH"
          },
          "direct" => %{
            "request" => "FPX_B2B_KFH",
            "response" => "FPX_B2B_KFH"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_KFH_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_KFH_120.gif"
      },
      %{
        "title" => "OCBC Bank B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_OCBC",
            "response" => "FPX_B2B_OCBC"
          },
          "seamless" => %{
            "request" => "FPX_B2B_OCBC",
            "response" => "FPX_B2B_OCBC"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_OCBC",
            "response" => "FPX_B2B_OCBC"
          },
          "direct" => %{
            "request" => "FPX_B2B_OCBC",
            "response" => "FPX_B2B_OCBC"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_OCBC_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_OCBC_120.gif"
      },
      %{
        "title" => "Public Bank B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_PBB",
            "response" => "FPX_B2B_PBB"
          },
          "seamless" => %{
            "request" => "FPX_B2B_PBB",
            "response" => "FPX_B2B_PBB"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_PBB",
            "response" => "FPX_B2B_PBB"
          },
          "direct" => %{
            "request" => "FPX_B2B_PBB",
            "response" => "FPX_B2B_PBB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_PBB__48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_PBB_120.gif"
      },
      %{
        "title" => "Public Bank Enterprise B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_PBBE",
            "response" => "FPX_B2B_PBBE"
          },
          "seamless" => %{
            "request" => "FPX_B2B_PBBE",
            "response" => "FPX_B2B_PBBE"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_PBBE",
            "response" => "FPX_B2B_PBBE"
          },
          "direct" => %{
            "request" => "FPX_B2B_PBBE",
            "response" => "FPX_B2B_PBBE"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_PBBE_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_PBBE_120.gif"
      },
      %{
        "title" => "RHB Reflex B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_RHB",
            "response" => "FPX_B2B_RHB"
          },
          "seamless" => %{
            "request" => "FPX_B2B_RHB",
            "response" => "FPX_B2B_RHB"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_RHB",
            "response" => "FPX_B2B_RHB"
          },
          "direct" => %{
            "request" => "FPX_B2B_RHB",
            "response" => "FPX_B2B_RHB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_RHB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_RHB_120.gif"
      },
      %{
        "title" => "Standard Chartered Bank B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_SCB",
            "response" => "FPX_B2B_SCB"
          },
          "seamless" => %{
            "request" => "FPX_B2B_SCB",
            "response" => "FPX_B2B_SCB"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_SCB",
            "response" => "FPX_B2B_SCB"
          },
          "direct" => %{
            "request" => "FPX_B2B_SCB",
            "response" => "FPX_B2B_SCB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_SCB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_SCB_120.gif"
      },
      %{
        "title" => "United Overseas Bank B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_UOB",
            "response" => "FPX_B2B_UOB"
          },
          "seamless" => %{
            "request" => "FPX_B2B_UOB",
            "response" => "FPX_B2B_UOB"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_UOB",
            "response" => "FPX_B2B_UOB"
          },
          "direct" => %{
            "request" => "FPX_B2B_UOB",
            "response" => "FPX_B2B_UOB"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_UOB_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_UOB_120.gif"
      },
      %{
        "title" => "UOB Regional B2B (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_B2B_UOBR",
            "response" => "FPX_B2B_UOBR"
          },
          "seamless" => %{
            "request" => "FPX_B2B_UOBR",
            "response" => "FPX_B2B_UOBR"
          },
          "seamlesspayment" => %{
            "request" => "FPX_B2B_UOBR",
            "response" => "FPX_B2B_UOBR"
          },
          "direct" => %{
            "request" => "FPX_B2B_UOBR",
            "response" => "FPX_B2B_UOBR"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_B2B_UOBR_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_B2B_UOBR_120.gif"
      },
      %{
        "title" => "Maybank2E (FPX)",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "FPX_M2E",
            "response" => "FPX_M2E"
          },
          "seamless" => %{
            "request" => "FPX_M2E",
            "response" => "FPX_M2E"
          },
          "seamlesspayment" => %{
            "request" => "FPX_M2E",
            "response" => "fpx_m2e"
          },
          "direct" => %{
            "request" => "FPX_M2E",
            "response" => "FPX_M2E"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/fpx.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/fpx.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/fpx.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/FPX_M2E_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/FPX_M2E_120.gif"
      },
      %{
        "title" => "GrabPay",
        "status" => 1,
        "currency" => [
          "MYR",
          "PHP",
          "SGD"
        ],
        "channel_type" => "EW",
        "channel_map" => %{
          "hosted" => %{
            "request" => "GrabPay",
            "response" => "GrabPay"
          },
          "seamless" => %{
            "request" => "GrabPay",
            "response" => "GrabPay"
          },
          "seamlesspayment" => %{
            "request" => "GrabPay",
            "response" => "GrabPay"
          },
          "direct" => %{
            "request" => "GRABPAY",
            "response" => "GRABPAY"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/GrabPay.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/GrabPay.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/GrabPay.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/GrabPay.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/GrabPay.gif"
      },
      %{
        "title" => "ธนาคารกสิกรไทย แอพ K-PLUS",
        "status" => 1,
        "currency" => [
          "THB"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "KBANK_PayPlus",
            "response" => "KBANK_PayPlus"
          },
          "seamless" => %{
            "request" => "KBANK_PayPlus",
            "response" => "KBANK_PayPlus"
          },
          "seamlesspayment" => %{
            "request" => "KBANK_PAYPLUS",
            "response" => "KBANK_PayPlus"
          },
          "direct" => %{
            "request" => "KBANK_PAYPLUS",
            "response" => "KBANK_PayPlus"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/TH_PB_KBANK_16.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/TH_PB_KBANK_24.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/TH_PB_KBANK_32.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/TH_PB_KBANK_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/TH_PB_KBANK_180.gif"
      },
      %{
        "title" => "Unionpay",
        "status" => 1,
        "currency" => [
          "MYR",
          "USD",
          "CNY",
          "AUD",
          "CAD",
          "EUR",
          "GBP",
          "HKD",
          "IDR",
          "JPY",
          "NZD",
          "PHP",
          "SGD",
          "THB",
          "TWD",
          "VND"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "GUPOP",
            "response" => "GUPOP"
          },
          "seamless" => %{
            "request" => "GUPOP",
            "response" => "GUPOP"
          },
          "seamlesspayment" => %{
            "request" => "GUPOP",
            "response" => "GUPOP"
          },
          "direct" => %{
            "request" => "GUPOP",
            "response" => "GUPOP"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/unionpay.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/unionpay.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/unionpay.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/unionpay.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/unionpay.gif"
      },
      %{
        "title" => "แจ้งเตือนเพื่อจ่ายผ่านพร้อมเพย์",
        "status" => 1,
        "currency" => [
          "THB"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "KBANK_RTP",
            "response" => "KBANK_RTP"
          },
          "seamless" => %{
            "request" => "KBANK_RTP",
            "response" => "KBANK_RTP"
          },
          "seamlesspayment" => %{
            "request" => "KBANK_RTP",
            "response" => "KBANK_RTP"
          },
          "direct" => %{
            "request" => "KBANK_RTP",
            "response" => "KBANK_RTP"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/prompt-pay_16x16.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/prompt-pay_24.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/prompt-pay_32.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/prompt-pay_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/prompt-pay_120.gif"
      },
      %{
        "title" => "ชำระด้วย QR PromptPay",
        "status" => 1,
        "currency" => [
          "THB"
        ],
        "channel_type" => "EW",
        "channel_map" => %{
          "hosted" => %{
            "request" => "KBANK_THQR_Payment",
            "response" => "KBANK_THQR_Payment"
          },
          "seamless" => %{
            "request" => "KBANK_THQR_Payment",
            "response" => "KBANK_THQR_Payment"
          },
          "seamlesspayment" => %{
            "request" => "KBANK_THQR_Payment",
            "response" => "KBANK_THQR_Payment"
          },
          "direct" => %{
            "request" => "KBANK_THQR_Payment",
            "response" => "KBANK_THQR_Payment"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/PromptPay_16x16.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/PromptPay_24.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/PromptPay_32.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/PromptPay_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/PromptPay_120.gif"
      },
      %{
        "title" => "ธนาคารกรุงไทย (ลูกค้าจ่ายค่าธรรมเนียม)",
        "status" => 1,
        "currency" => [
          "THB"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "KTB_IB_U",
            "response" => "KTB_IB_U"
          },
          "seamless" => %{
            "request" => "KTB_IB_U",
            "response" => "KTB_IB_U"
          },
          "seamlesspayment" => %{
            "request" => "KTB_IB_U",
            "response" => "KTB_IB_U"
          },
          "direct" => %{
            "request" => "KTB_IB_U",
            "response" => "KTB_IB_U"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/krungthai.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/krungthai.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/krungthai.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/krungthai.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/krungthai.gif"
      },
      %{
        "title" => "Maya e-Wallet",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "EW",
        "channel_map" => %{
          "hosted" => %{
            "request" => "PayMaya-eWallet",
            "response" => "PayMaya-eWallet"
          },
          "seamless" => %{
            "request" => "PAYMAYA-EWALLET",
            "response" => "PayMaya-eWallet"
          },
          "seamlesspayment" => %{
            "request" => "PAYMAYA-EWALLET",
            "response" => "PayMaya-eWallet"
          },
          "direct" => %{
            "request" => "PAYMAYA-EWALLET",
            "response" => "PayMaya-eWallet"
          },
          "offline" => %{
            "request" => "PAYMAYA-EWALLET",
            "response" => "PayMaya-eWallet"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/maya.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/maya.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/maya.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/maya.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/maya.gif"
      },
      %{
        "title" => "PayNow",
        "status" => 1,
        "currency" => [
          "SGD"
        ],
        "channel_type" => "EW",
        "channel_map" => %{
          "hosted" => %{
            "request" => "PayNow",
            "response" => "PayNow"
          },
          "seamless" => %{
            "request" => "PayNow",
            "response" => "PayNow"
          },
          "seamlesspayment" => %{
            "request" => "PayNow",
            "response" => "PayNow"
          },
          "direct" => %{
            "request" => "PAYNOW",
            "response" => "PAYNOW"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/paynow-16.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/paynow-24.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/paynow-32.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/paynow-48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/paynow-120.gif"
      },
      %{
        "title" => "DuitNow QR",
        "status" => 1,
        "currency" => [
          "RM",
          "MYR"
        ],
        "channel_type" => "EW",
        "channel_map" => %{
          "hosted" => %{
            "request" => "RPP_DuitNowQR",
            "response" => "RPP_DuitNowQR"
          },
          "seamless" => %{
            "request" => "RPP_DuitNowQR",
            "response" => "RPP_DuitNowQR"
          },
          "seamlesspayment" => %{
            "request" => "RPP_DuitNowQR",
            "response" => "RPP_DuitNowQR"
          },
          "direct" => %{
            "request" => "RPP_DUITNOWQR",
            "response" => "RPP_DUITNOWQR"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/RPP_DuitNowQR.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/RPP_DuitNowQR.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/RPP_DuitNowQR.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/RPP_DuitNowQR.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/RPP_DuitNowQR.gif"
      },
      %{
        "title" => "ธนาคารไทยพาณิชย์ (ลูกค้าจ่ายค่าธรรมเนียม)",
        "status" => 1,
        "currency" => [
          "THB"
        ],
        "channel_type" => "IB",
        "channel_map" => %{
          "hosted" => %{
            "request" => "SCB_IB_U",
            "response" => "SCB_IB_U"
          },
          "seamless" => %{
            "request" => "SCB_IB_U",
            "response" => "SCB_IB_U"
          },
          "seamlesspayment" => %{
            "request" => "SCB_IB_U",
            "response" => "SCB_IB_U"
          },
          "direct" => %{
            "request" => "SCB_IB_U",
            "response" => "SCB_IB_U"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/scb.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/scb.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/scb.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/scb.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/scb.gif"
      },
      %{
        "title" => "ShopeePay",
        "status" => 1,
        "currency" => [
          "MYR",
          "SGD",
          "PHP"
        ],
        "channel_type" => "EW",
        "channel_map" => %{
          "hosted" => %{
            "request" => "ShopeePay",
            "response" => "ShopeePay"
          },
          "seamless" => %{
            "request" => "ShopeePay",
            "response" => "ShopeePay"
          },
          "seamlesspayment" => %{
            "request" => "ShopeePay",
            "response" => "ShopeePay"
          },
          "direct" => %{
            "request" => "SHOPEEPAY",
            "response" => "SHOPEEPAY"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/ShopeePay.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/ShopeePay.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/ShopeePay.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/ShopeePay.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/ShopeePay.gif"
      },
      %{
        "title" => "Touch `n Go eWallet",
        "status" => 1,
        "currency" => [
          "MYR"
        ],
        "channel_type" => "EW",
        "channel_map" => %{
          "hosted" => %{
            "request" => "TNG-EWALLET",
            "response" => "TNG-EWALLET"
          },
          "seamless" => %{
            "request" => "TNG-EWALLET",
            "response" => "TNG-EWALLET"
          },
          "seamlesspayment" => %{
            "request" => "TNG-EWALLET",
            "response" => "TNG-EWALLET"
          },
          "direct" => %{
            "request" => "TNG-EWALLET",
            "response" => "TNG-EWALLET"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/TNG-EWALLET-Offline.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/TNG-EWALLET-Offline.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/TNG-EWALLET-Offline.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/TNG-EWALLET-Offline.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/TNG-EWALLET-Offline.gif"
      },
      %{
        "title" => "WeChatPay",
        "status" => 1,
        "currency" => [
          "MYR"
        ],
        "channel_type" => "EW",
        "channel_map" => %{
          "hosted" => %{
            "request" => "WeChatPay",
            "response" => "WeChatPay"
          },
          "seamless" => %{
            "request" => "WeChatPay",
            "response" => "WeChatPay"
          },
          "seamlesspayment" => %{
            "request" => "WeChatPay",
            "response" => "WeChatPay"
          },
          "direct" => %{
            "request" => "WeChatPay",
            "response" => "WeChatPay"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/wechatpay-16x16.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/wechatpay-24x24.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/wechatpay-32x32.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/wechatpay-48x48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/wechatpay-120x120.gif"
      },
      %{
        "title" => "GCash",
        "status" => 1,
        "currency" => [
          "PHP"
        ],
        "channel_type" => "EW",
        "channel_map" => %{
          "hosted" => %{
            "request" => "GCash",
            "response" => "GCash"
          },
          "seamless" => %{
            "request" => "GCash",
            "response" => "GCash"
          },
          "seamlesspayment" => %{
            "request" => "GCash",
            "response" => "GCash"
          },
          "direct" => %{
            "request" => "GCash",
            "response" => "GCash"
          }
        },
        "logo_url_16x16" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/16/gcash_16.gif",
        "logo_url_24x24" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/24/gcash_24.gif",
        "logo_url_32x32" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/32/gcash_32.gif",
        "logo_url_48x48" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/48/gcash_48.gif",
        "logo_url_120x43" =>
          "https =>//d2x73ruoixi2ei.cloudfront.net/images/logos/channels/120/gcash_120.gif"
      }
    ]
  end
end
