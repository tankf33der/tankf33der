# 12may22 Software Lab. Alexander Burger
# Matrix API

(load "@lib/json.l")

(symbols 'matrix 'pico)

# https://matrix-org.github.io/synapse/latest/usage/administration/admin_api/index.html
# https://spec.matrix.org/latest/client-server-api

(local) (*Site *Token #{*Device}# result login mcGet saGet deleteRoom
deleteStatus versions capabilities whoami publicRooms rooms)

# Utils
(de result @
   (let? R (readJson)
      (while (next)
         (set @
            (let A (next)
               (if (atom A)
                  (get R A)
                  (apply get A R) ) ) ) )
      R ) )

(de login (Usr Pw)
   (pipe
      (out
         (list "curl" "-s"  "--json" "@-"
            (pack "https://" *Site "/_matrix/client/v3/login") )
         (printJson
            (list
               '(type . "m.login.password")
               (list 'identifier
                  '(type . "m.id.user")
                  (cons 'user Usr) )
               (cons 'password Pw)
               '(initial_device_display_name . "PicoLisp") ) ) )
      (result
         '*Token 'access_token
         #{'*Device '(well_known m.homeserver base_url)}# ) ) )

# Matrix Client
(de mcGet (V . @)
   (in
      (list "curl" "-s"
         "-H" (pack "Authorization: Bearer " *Token)
         (pass pack "https://" *Site "/_matrix/client/v" V "/") )
      (result) ) )

# Synapse Admin
(de saGet (V . @)
   (in
      (list "curl" "-s"
         "-H" (pack "Authorization: Bearer " *Token)
         (pass pack "https://" *Site "/_synapse/admin/v" V "/") )
      (result) ) )

(de deleteRoom (Id)
   (pipe
      (out
         (list "curl" "-s" "-XDELETE"  "--json" "@-"
            "-H" (pack "Authorization: Bearer " *Token)
            (pack "https://" *Site "/_synapse/admin/v2/rooms/" Id) )
         (printJson
            '((block . false) (purge . true)) ) )
      (result) ) )

(de deleteStatus (Id)
   (saGet 2 "rooms/" Id "/delete_status") )

# Infos
(de versions ()
   (ssl *Site "_matrix/client/versions"
      (result) ) )

(de capabilities ()
   (mcGet 3 "capabilities") )

(de whoami ()
   (mcGet 3 "account/whoami") )

(de publicRooms ()
   (mcGet 3 "publicRooms") )

(de rooms @
   (pass saGet 1 "rooms") )

# Events
(local) (sync messages)

(de sync ()
   (mcGet 3 "sync") )

(de messages (Room)
   (mcGet 3 "rooms/" Room "/messages") )

# Start
(local) (main go)

# -matrix~main
(de main ()
   (symbols '(matrix pico)) )

# -go <usr>
(de go (Usr)
   (let
      (L (split (chop Usr) "@" ":")
         R (rc ".matrix" Usr) )
      (setq *Site (pack (caddr L)))
      (cond
         ((cdr R) (setq *Token @))
         (R (login (pack (cadr L)) (car R)))
         (T (quit "Site not found")) ) ) )
