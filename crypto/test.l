(load "test-des.l")
(load "test-hkdf.l")
(load "test-pbkdf2.l")
(load "test-hmac.l")
(load "test-md5.l")
(load "test-md2.l")
(load "md2.l")
(load "aes.l")
(load "test-aes.l")
(load "keccak.l")
(load "test-keccak.l")
(load "sha512.l")
(load "test-sha512.l")
(load "ed25519.l")
(load "../rosetta/sha256.l")
(load "test-sha256.l")
(load "test-ripemd160.l")
(load "blowfish.l")
(load "test-blowfish.l")
(load "test-bcrypt.l")
(load "twofish.l")
(load "test-twofish.l")
(load "blake.l")
(load "threefish.l")
(load "test-threefish.l")
(load "rc2.l")
(load "test-rc2.l")
(load "rc5.l")
(load "test-rc5.l")
(load "rc6.l")
(load "test-rc6.l")
(load "camellia.l")
(load "test-camellia.l")
(load "idea.l")
(load "test-idea.l")
(load "test-md4.l")
(load "test-sha1.l")
(load "grostl.l")
(load "tiger.l")
(load "test-tiger.l")
(load "whirlpool.l")
(load "test-whirlpool.l")
(load "jh.l")
(load "test-jh.l")
(load "skein.l")
(load "test-anubis.l")
(load "test-scrypt.l")
(load "test-blake2s.l")
(load "test-blake2.l")
(load "test-kangaroo12.l")

(de bigToL (N)
   (let R NIL
      (do 8
         (push 'R (& 255 N))
         (setq N (>> 8 N)) )
      R ) )

(de bigFromL (L)
   (apply
      |
      (mapcar >> (-56 -48 -40 -32 -24 -16 -8 0) L) ) )

# SKEIN
(test
   (11 152 220 209 152 234 14 80 167 162 68 196 68 226 92 35 218 48 193 15 201 161 242 112 166 99 127 31 52 230 126 210)
   (skein256 (need 1 255)) )
(test
   (50 79 223 169 231 46 211 57 25 189 33 44 74 69 210 195 232 40 245 29 50 168 179 188 199 146 81 33 250 167 98 71)
   (skein256 (need 10 255)) )
(test
   (25 204 67 82 43 235 176 252 142 26 0 144 209 239 27 26 226 126 167 192 140 112 239 30 234 206 219 9 246 64 152 63)
   (skein256 (need 1000 255)) )
(test
   (113 237 169 219 57 156 125 81 147 143 107 124 82 104 155 98 72 148 45 58 130 7 108 102 200 194 140 154 101 180 109 164)
   (skein256 (need 10000 255)) )
(test
   (117 126 170 51 81 182 163 54 17 139 167 101 194 31 119 139 252 133 168 59 198 6 240 13 189 79 149 163 17 112 205 46)
   (skein256 (need 1000000 255)) )

# JH
(test
   "7C2BE49C8A924D94B90CD4CBEAFE0F4F41BC9DBEB17A9C49BC089608B6EE6A5C"
   (jh256_hex (need 4 64)) )

# Whirlpool
(test
   "19FA61D75522A4669B44E39C1D2E1726C530232130D407F89AFEE0964997F7A73E83BE698B288FEBCF88E3E03C4F0757EA8964E59B63D93708B138CC42A66EB3"
   (whirlpool_hex) )
(test
   "B97DE512E91E3828B40D2B0FDCE9CEB3C4A71F9BEA8D88E75C4FA854DF36725FD2B52EB6544EDCACD6F8BEDDFEA403CB55AE31F03AD62A5EF54E42EE82C3FB35"
   (whirlpool_hex (mapcar char (chop "The quick brown fox jumps over the lazy dog"))) )
(test
   "C27BA124205F72E6847F3E19834F925CC666D0974167AF915BB462420ED40CC50900D85A1F923219D832357750492D5C143011A76988344C2635E69D06F2D38C"
   (whirlpool_hex (mapcar char (chop "The quick brown fox jumps over the lazy eog"))) )

# Tiger192
(test
   "3293AC630C13F0245F92BBB1766E16167A4E58492DDE73F3"
   (tiger192_hex) )
(test
   "2AAB1484E8C158F2BFB8C5FF41B57A525129131C957B5F93"
   (tiger192_hex (mapcar char (chop "abc"))) )
(test
   "F71C8583902AFB879EDFE610F82C0D4786A3A534504486B5"
   (tiger192_hex (mapcar char (chop "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-"))) )
(test
   "48CEEB6308B87D46E95D656112CDF18D97915F9765658957"
   (tiger192_hex (mapcar char (chop "ABCDEFGHIJKLMNOPQRSTUVWXYZ=abcdefghijklmnopqrstuvwxyz+0123456789"))) )
(test
   "6D12A41E72E644F017B6F0E2F7B44C6285F06DD5D2C5B075"
   (tiger192_hex (mapcar char (chop "The quick brown fox jumps over the lazy dog"))) )
(test
   "A8F04B0F7201A0D728101C9D26525B31764A3493FCD8458F"
   (tiger192_hex (mapcar char (chop "The quick brown fox jumps over the lazy cog"))) )
(test
   "6DB0E2729CBEAD93D715C6A7D36302E9B3CEE0D2BC314B41"
   (tiger192_hex (need 1000000 97)) )

# GROSTL-256
(test
   "1A52D11D550039BE16107F9C58DB9EBCC417F16F736ADB2502567119F0083467"
   (grostl256_hex) )
(test
   "F3C1BB19C048801326A7EFBCF16E3D7887446249829C379E1840D1A3A1E7D4D2"
   (grostl256_hex (mapcar char (chop "abc"))) )
(test
   "8C7AD62EB26A21297BC39C2D7293B4BD4D3399FA8AFAB29E970471739E28B301"
   (grostl256_hex
      (mapcar char (chop "The quick brown fox jumps over the lazy dog")) ) )
(test
   "F48290B1BCACEE406A0429B993ADB8FB3D065F4B09CBCDB464A631D4A0080AAF"
   (grostl256_hex
      (mapcar char (chop "The quick brown fox jumps over the lazy dog.")) ) )
(test
   "8EC368308BF653A1AE72058C0538A66AEA35F0C80BD0108DBB9D749CC652D846"
   (grostl256_hex
      (mapcar char (chop "The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.")) ) )
(test
   "D9501C3FFCB10D13E5451FB722B1FB9DA16ABE917840CFA2039114100CF7962E"
   (grostl256_hex
      (mapcar char (chop "The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.")) ) )

# IDEA
(test
   (82 0 148 97 228 243 127 71)
   (idea (need 8 250) (need 16 250)) )
(test
   (8 176 43 63 118 136 144 50)
   (idea (need 8 251) (need 16 251)) )
(test
   (119 233 217 64 93 53 241 204)
   (idea (need 8 252) (need 16 252)) )
(test
   (26 16 227 243 24 174 218 154)
   (idea (need 8 253) (need 16 253)) )
(test
   (220 109 153 1 45 192 30 11)
   (idea (need 8 254) (need 16 254)) )
(test
   (205 26 178 193 33 16 65 251)
   (idea (need 8 255) (need 16 255)) )

# CAMELLIA
(test
   (102 174 30 175 180 80 145 152 46 64 0 11 173 224 2 201)
   (camellia128 (need 16 250) (need 16 250)) )
(test
   (182 97 75 15 245 146 77 12 30 178 196 97 86 11 252 1)
   (camellia128 (need 16 251) (need 16 251)) )
(test
   (91 77 251 226 187 118 102 66 90 133 140 71 105 216 218 208)
   (camellia128 (need 16 252) (need 16 252)) )
(test
   (47 20 43 144 68 222 195 153 21 237 147 71 231 176 237 30)
   (camellia128 (need 16 253) (need 16 253)) )
(test
   (23 224 37 40 214 101 92 234 123 230 184 84 143 194 218 101)
   (camellia128 (need 16 254) (need 16 254)) )
(test
   (37 221 158 185 221 103 251 198 232 67 31 86 244 251 230 81)
   (camellia128 (need 16 255) (need 16 255)) )

# RC6
(test
   (59 2 97 185 218 145 52 111 173 132 221 156 201 236 74 55)
   (rc6 (need 16 250) (need 16 250)) )
(test
   (159 62 145 48 21 17 64 158 31 153 122 8 15 154 148 36)
   (rc6 (need 16 251) (need 16 251)) )
(test
   (241 191 92 206 154 125 95 190 117 154 87 150 64 52 134 146)
   (rc6 (need 16 252) (need 16 252)) )
(test
   (209 146 203 200 14 101 60 18 198 71 193 235 235 86 174 16)
   (rc6 (need 16 253) (need 16 253)) )
(test
   (100 245 179 233 27 76 195 195 90 251 103 147 252 236 131 106)
   (rc6 (need 16 254) (need 16 254)) )
(test
   (239 177 9 151 132 34 229 15 220 176 83 53 208 80 208 215)
   (rc6 (need 16 255) (need 16 255)) )

# RC5
(test
   (118 18 69 84 235 228 67 137)
   (rc5 (need 8 250) (need 16 250)) )
(test
   (109 98 163 143 119 188 75 135)
   (rc5 (need 8 251) (need 16 251)) )
(test
   (166 58 43 41 158 22 227 240)
   (rc5 (need 8 252) (need 16 252)) )
(test
   (187 188 124 200 45 227 212 138)
   (rc5 (need 8 253) (need 16 253)) )
(test
   (90 148 24 47 62 165 223 218)
   (rc5 (need 8 254) (need 16 254)) )
(test
   (119 135 105 233 190 1 103 183)
   (rc5 (need 8 255) (need 16 255)) )

# RC2
(test
   (235 183 115 249 147 39 142 255)
   (rc2 (need 8 0) (need 8 0)) )
(test
   (39 139 39 228 46 47 13 73)
   (rc2 (need 8 255) (need 8 255)) )
(test
   (48 100 158 223 155 231 210 194)
   (rc2 (16 0 0 0 0 0 0 1) (48 0 0 0 0 0 0 0)) )

# blake
(test
   "0CE8D4EF4DD7CD8D62DFDED9D4EDB0A774AE6A41929A74DA23109E8F11139C87"
   (blake256_hex (0)) )
(test
   "7576698EE9CAD30173080678E5965916ADBB11CB5245D386BF1FFDA1CB26C9D7"
   (blake256_hex (mapcar char (chop "The quick brown fox jumps over the lazy dog"))) )
(test
   "07663E00CF96FBC136CF7B1EE099C95346BA3920893D18CC8851F22EE2E36AA6"
   (blake256_hex (mapcar char (chop "BLAKE"))) )
(test
   "18A393B4E62B1887A2EDF79A5C5A5464DAF5BBB976F4007BEA16A73E4C1E198E"
   (blake256_hex (mapcar char (chop "'BLAKE wins SHA-3! Hooray!!!' (I have time machine)"))) )
(test
   "AF95FFFC7768821B1E08866A2F9F66916762BFC9D71C4ACB5FD515F31FD6785A"
   (blake256_hex (mapcar char (chop "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus. Sed sit amet ipsum mauris. Maecenas congu"))) )
(test
   "4181475CB0C22D58AE847E368E91B4669EA2D84BCD55DBF01FE24BAE6571DD08"
   (blake256_hex (mapcar char (chop "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus. Sed sit amet ipsum mauris. Maecenas congue ligula ac quam viverra nec consectetur ante hendrerit. Donec et mollis dolor. Praesent et diam eget libero egestas mattis sit amet vitae augue. Nam tincidunt congue enim, ut porta lorem lacinia consectetur. Donec ut libero sed arcu vehicula ultricies a non tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ut gravida lorem. Ut turpis felis, pulvinar a semper sed, adipiscing id dolor. Pellentesque auctor nisi id magna consequat sagittis. Curabitur dapibus enim sit amet elit pharetra tincidunt feugiat nisl imperdiet. Ut convallis libero in urna ultrices accumsan. Donec sed odio eros. Donec viverra mi quis quam pulvinar at malesuada arcu rhoncus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. In rutrum accumsan ultricies. Mauris vitae nisi at sem facilisis semper ac in est."))) )
(test
   "716F6E863F744B9AC22C97EC7B76EA5F5908BC5B2F67C61510BFC4751384EA7A"
   (blake256_hex (mapcar char)) )
(test
   "F2E9223281B895E7947AD81CCFD873F93AF110F408222AAFADDCB64E999EC835"
   (blake256_hex (mapcar char (chop "mike"))) )
(test
   "B25C02CCFA1F664D25A15D999B56A4BE1AD84A029A96BE5D654387A2DEF99916"
   (blake256_hex (mapcar char (chop "Kilroy was here!"))) )
(test
   "49E02B55D9F6F2AAD1934D9D937167FB0D9922CAA080EF4F76CAB13E12B3DCB7"
   (blake256_hex (mapcar char (chop "123456789012345678901234567890"))) )
(test
   "789B919AEEBAB1828AE8D5286258590B8E13690328D44FD7B73BC003B0A6E05E"
   (blake256_hex (mapcar char (chop "123456789012345678901234567891234567890123456789"))) )
(test
   "72E8FEF7D3BEFF475645B65E6B76DDF20F5922CD827487F3111248E25F771CBF"
   (blake256_hex (mapcar char (chop "123456789012345678901234567891234567890123456789123456789012345678901234567891234567890123456789"))) )
(test
   "88A93F7C11F78D2064E4FFD467E95FFF14484E04F271F4468F89B5FEC72E8453"
   (blake256_hex (mapcar char (chop "123456789012345678901234567891234567890123456789123456789012345678901234567891234567890123456789123456789012345678901234567891234567890123456789123456789012345678901234567891234567890123456789"))) )
(test
   "D95A160D1341A5E3847C2ECD0D7F61E98F8B528EFDE5B0DF8492048A4666C877"
   (blake256_hex (mapcar char (chop "12345678901234567890123456789012345678901234567890123451234567890123456789012345678901234567890123456789012345"))) )
# important padding extensions tests
(test
   "A53E6DA06F1DA6AABC1FC77132F2C1AAC820A5A373B7660FEB7FC125EC68A9B2"
   (blake256_hex (mapcar char (chop "12345678901234567890123456789012345678901234567890123"))) )
(test
   "1CAE1511B1126E061413A89B74B2B4587402F0EC5EA42EC680148F30C5FA06C8"
   (blake256_hex (mapcar char (chop "123456789012345678901234567890123456789012345678901234"))) )
(test
   "FE735E33776658B54C2301996D10D164B87A0C8B4125E50427D8C6C8ACB39ECB"
   (blake256_hex (mapcar char (chop "1234567890123456789012345678901234567890123456789012345"))) )
(test
   "7790FDBCFBD7C8C7E974401651973460B69544EE8A855F582C0F0DE2CB8A53B5"
   (blake256_hex (mapcar char (chop "123456789012345678901234567890123456789012345678901234567890123"))) )
(test
   "249CE61E13BF8A3ECCA7F88BE7DD5E27BBD2BA9156260EF844DE5B4672E8E8A2"
   (blake256_hex (mapcar char (chop "1234567890123456789012345678901234567890123456789012345678901234"))) )
(test
   "85A7F5A19C5CE63CB4457F248AF0689D90D09D9130D12103D42B73AF6A8ECAC4"
   (blake256_hex (mapcar char (chop "12345678901234567890123456789012345678901234567890123456789012345"))) )
(test
   "71FF0ACEC76E2BF9A5A2A770B9A0F1DDD41A7D6DBE2EB2F7FE2CA354843B5977"
   (blake256_hex (mapcar char (chop "123456789012345678901234567890123456789012345678901234567890123456"))) )
(test
   "0324EB0F2F8B397BC73C82A9995C9D65B6AA46EAD96B557184B12EE332594699"
   (blake256_hex (mapcar char (chop "1234567890123456789012345678901234567890123456789012345678901234567"))) )
# 10k 'a
(test
   "66E5F51D62ACEABFD322833CBD23D18DC10573E25D4390AADD18F55B8859AE90"
   (blake256_hex (need 10000 97)) )

# twofish
(test
   "2AC20974A8848AC004591EA81C158850"
   (twofish_hex
      (mapcar char (chop "a"))
      (mapcar char (chop "a")) ) )
(test
   "CD6A124B2B3FB37165D20DEE7CAD34D9"
   (twofish_hex
      (mapcar char (chop "ab"))
      (mapcar char (chop "ab")) ) )
(test
   "443766D93C02A74A7A97B2EA4D2AC4F7"
   (twofish_hex
      (mapcar char (chop "abcdabcd"))
      (mapcar char (chop "abcdabcd")) ) )
(test
   "34E3122CD5E3007ADCC632F1556DE717"
   (twofish_hex
      (mapcar char (chop "abcdabcdabcdabcd"))
      (mapcar char (chop "abcdabcdabcdabcd")) ) )
(test
   "34E3122CD5E3007ADCC632F1556DE717D6F045BBAE2BAF402CC36CD3172A510F"
   (twofish_hex
      (mapcar char (chop "abcdabcdabcdabcd123"))
      (mapcar char (chop "abcdabcdabcdabcd")) ) )
(test
   "34E3122CD5E3007ADCC632F1556DE71799BDFE716888754D172AC3E67ADFCB9F"
   (twofish_hex
      (mapcar char (chop "abcdabcdabcdabcd123456"))
      (mapcar char (chop "abcdabcdabcdabcd")) ) )
(test
   "34E3122CD5E3007ADCC632F1556DE717A05B3094975F291A50192A0BFB9705CF"
   (twofish_hex
      (mapcar char (chop "abcdabcdabcdabcd1234567890"))
      (mapcar char (chop "abcdabcdabcdabcd")) ) )
(test
   "34E3122CD5E3007ADCC632F1556DE717881ECCB3EA32A4F443ABE24A5EBB12864E16612CE4D3C7503870A50F0B3F67D8"
   (twofish_hex
      (mapcar char (chop "abcdabcdabcdabcd12345678901234567890"))
      (mapcar char (chop "abcdabcdabcdabcd")) ) )

# blowfish
(test
   "D4CC18D7D4645EDC"
   (blowfish_hex
      (mapcar char (chop "a"))
      (mapcar char (chop "A")) ) )
(test
   "914C23FE723520FC"
   (blowfish_hex
      (mapcar char (chop "ab"))
      (mapcar char (chop "AB")) ) )
(test
   "92E509012CC9F256"
   (blowfish_hex
      (mapcar char (chop "abc"))
      (mapcar char (chop "ABC")) ) )
(test
   "B429E1AF407FA44C"
   (blowfish_hex
      (mapcar char (chop "abcd"))
      (mapcar char (chop "ABCD")) ) )
(test
   "884EF58BC9E39CF9CEEC019BD75C6BEC"
   (blowfish_hex
      (mapcar char (chop "mikemike1"))
      (mapcar char (chop "a1")) ) )
(test
   "2ECAB0DA3BD5E046FAAE4511861E394E"
   (blowfish_hex
      (mapcar char (chop "mikemikemike"))
      (mapcar char (chop "a11")) ) )
(test
   "DDC72F1560439C43DDC72F1560439C43"
   (blowfish_hex
      (mapcar char (chop "mikemikemikemike"))
      (mapcar char (chop "a111")) ) )
(test
   "F52F1D6C3AB97DEEF52F1D6C3AB97DEEA3030C4557CFD1F2"
   (blowfish_hex
      (mapcar char (chop "mikemikemikemikemike"))
      (mapcar char (chop "a1111")) ) )
(test
   "DBD73EE08F6A9446DBD73EE08F6A9446DBD73EE08F6A9446"
   (blowfish_hex
      (mapcar char (chop "mikemikemikemikemikemike"))
      (mapcar char (chop "a11111")) ) )
(test
   "B07D429157E21001B07D429157E21001B07D429157E210014CA595687C75D754"
   (blowfish_hex
      (mapcar char (chop "mikemikemikemikemikemikemike"))
      (mapcar char (chop "a111111")) ) )
(test
   "5681DC843E15164E5681DC843E15164E5681DC843E15164E5681DC843E15164E"
   (blowfish_hex
      (mapcar char (chop "mikemikemikemikemikemikemikemike"))
      (mapcar char (chop "a1111111")) ) )
(test
   "DBDC9DE162C65D1CDBDC9DE162C65D1CDBDC9DE162C65D1CDBDC9DE162C65D1C3B63A92D455AB578"
   (blowfish_hex
      (mapcar char (chop "mikemikemikemikemikemikemikemikemike"))
      (mapcar char (chop "a11111111")) ) )

# MD2
(test
   (131 80 229 163 226 76 21 61 242 39 92 159 128 105 39 115)
   (md2) )
(test
   (50 236 1 236 74 109 172 114 192 171 150 251 52 192 181 209)
   (md2 (mapcar char (chop "a"))) )
(test
   (218 133 59 13 63 136 217 155 48 40 58 105 230 222 214 187)
   (md2 (mapcar char (chop "abc"))) )
(test
   (171 79 73 107 251 42 83 11 33 159 243 48 49 254 6 176)
   (md2 (mapcar char (chop "message digest"))) )
(test
   (78 141 223 243 101 2 146 171 90 65 8 195 170 71 148 11)
   (md2 (mapcar char (chop "abcdefghijklmnopqrstuvwxyz"))) )
(test
   (218 51 222 242 164 45 241 57 117 53 40 70 195 3 56 205)
   (md2
      (mapcar
         char
         (chop "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789") ) ) )
(test
   (213 151 111 121 216 61 58 13 201 128 108 60 102 243 239 216)
   (md2
      (mapcar
         char
         (chop "12345678901234567890123456789012345678901234567890123456789012345678901234567890") ) ) )

# AES
(test
   "66E94BD4EF8A2C3B884CFA59CA342B2E"
   (aes (need 16 0) (need 16 0)) )
(test
   "3925841D02DC09FBDC118597196A0B32"
   (aes
      (50 67 246 168 136 90 48 141 49 49 152 162 224 55 7 52)
      (43 126 21 22 40 174 210 166 171 247 21 136 9 207 79 60) ) )
(setq Tests
   (quote
      "5E77E59F8F85943489A24149C75F4EC9"
      "43B378ED857DA9A583C856EB51863406"
      "A96234EEBFEE97D21499E90E501572D1"
      "C919680C70B6A9BA9DA6F83E9326D306"
      "1DA2B348D561131CC9A404F09CE882A0"
      "D72321731DB4F1DB7D5337BE01845B7E"
      "DB52A07084A53D581CA429B3D2B910CC"
      "E6647CDF2A31972EA75D172D05675C47"
      "2BE7DCE7F186D5028A73C66F608F3F88" ) )
(for (I . N) Tests
   (let L (need 16 I)
      (test N (aes L L)) ) )

# KECCAK
(test
   (107 78 3 66 54 103 219 183 59 110 21 69 79 14 177 171 212 89 127 154 27 7 142 63 91 90 107 199)
   (sha3-224) )
(test
   (127 156 43 164 232 143 130 125 97 96 69 80 118 5 133 62 215 59 128 147 246 239 188 136 235 26 110 172 250 102 239 38)
   (shake128) )
(test
   (70 185 221 43 11 168 141 19 35 59 63 235 116 62 235 36 63 205 82 234 98 184 27 130 181 12 39 100 110 213 118 47 215 93 196 221 216 192 242 0 203 5 1 157 103 181 146 246 252 130 28 73 71 154 180 134 64 41 46 172 179 183 196 190)
   (shake256) )
(test
   (150 107 192 206 149 76 106 136)
   (head
      8
      (shake128 (need 2048 48)) ) )
(test
   (33 238 165 104 73 54 77 7)
   (head
      8
      (shake128 (need 2048 49)) ) )
(test
   (230 66 130 76 63 140 242 74)
   (head
      8
      (sha3-224 (mapcar char (chop "abc"))) ) )

# ed25519
(test
   'T
   (bool
      (and
         (>= *B 10)
         # 8 * len H "hash input"
         (=
            1
            (expmod 2 (dec *Q) *Q)
            (% *Q 4)
            (expmod 2 (dec *L) *L) )
         (>= *L (** 2 (- *B 4)))
         (<= *L (** 2 (- *B 3)))
         (=
            (dec *Q)
            (expmod *D (/ (dec *Q) 2) *Q)
            (expmod *I 2 *Q) )
         (= 0 (isoncurve *Bxy))
         (= (0 . 1) (scalarmult *Bxy *L))
      ) ) )

(test
   12345678901234567890
   (decodeint (encodeint 12345678901234567890)) )
(test
   (10405405258473914874183617234027007191356550210603093774830463659632760060427 . 3)
   (decodepoint (encodepoint (cons 3 3))) )
(test
   12875421174486089838561167381013564023947935085358512983004549604557448159382501491271815334843679443195583869113538088071367276186981820732797306589477704
   (Hint (mapcar char (chop "d"))) )
(test
   (1 62 31 236 99 175 55 203 36 74 245 116 36 102 211 171 147 45 164 233 19 187 84 144 225 213 65 101 170 83 45 15)
   (publickey (mapcar char (chop "mike"))) )
(test
   (195 130 154 147 158 168 211 248 12 69 169 159 155 201 66 156 45 213 183 140 176 242 63 255 83 58 254 233 253 170 129 48 59 230 67 55 194 42 105 243 212 137 111 228 126 27 105 39 226 56 50 244 226 207 233 20 78 60 107 178 28 9 92 11)
   (signature (0 0) (0 0) (0 0)) )
(let L (need 32 0)
   (test
      NIL
      (checkvalid
         (signature L L (need 32 0))
         L
         (need 32 0) ) ) )

(msg 'crypto-ALL-OK)

