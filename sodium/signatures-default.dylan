module: sodium
synopsis: friendly interface to signing
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define class <default-public-signing-key> (<public-signing-key>)
end class;

define class <default-secret-signing-key> (<secret-signing-key>)
end class;

define function crypto-sign-keypair
    ()
 => (public-key :: <default-public-signing-key>,
     secret-key :: <default-secret-signing-key>)
  let public-key-data = make(<C-string>, size: $crypto-sign-PUBLICKEYBYTES);
  let secret-key-data = make(<C-string>, size: $crypto-sign-SECRETKEYBYTES);
  %crypto-sign-keypair(public-key-data, secret-key-data); // TODO: Error handling
  let public-key = make(<default-public-signing-key>, data: public-key-data);
  let secret-key = make(<default-secret-signing-key>, data: secret-key-data);
  values(public-key, secret-key)
end;

define inline function crypto-sign-default-helper
    (payload :: <C-string>, payload-size :: <integer>,
     secret-key :: <default-secret-signing-key>)
 => (signed-payload :: <signed-payload>)
  let signed-payload = make(<C-string>, size: payload.size + $crypto-sign-BYTES);
  let signed-payload-len = make(<C-long*>);
  // TODO: Error handling
  %crypto-sign(signed-payload, signed-payload-len,
               payload, payload-size,
               secret-signing-key-data(secret-key));
  make(<signed-payload>, data: signed-payload,
       size: as(<integer>, C-long-at(signed-payload-len)))
end function;

define method crypto-sign
    (payload :: <byte-vector>, secret-key :: <default-secret-signing-key>)
 => (signed-payload :: <signed-payload>)
  with-c-string (payload-data = payload)
    crypto-sign-default-helper(payload-data, payload.size, secret-key)
  end with-c-string
end method;

define method crypto-sign
    (payload :: <byte-string>, secret-key :: <default-secret-signing-key>)
 => (signed-payload :: <signed-payload>)
  with-c-string (payload-data = payload)
    crypto-sign-default-helper(payload-data, payload.size, secret-key)
  end with-c-string
end method;

define method crypto-sign-open
    (signed-payload :: <signed-payload>,
     public-key :: <default-public-signing-key>)
 => (payload :: <byte-string>)
  let unsigned-message
    = make(<C-string>, size: signed-payload-size(signed-payload) - $crypto-sign-BYTES);
  let unsigned-message-len = make(<C-long*>);
  // TODO: Error handling
  %crypto-sign-open(unsigned-message, unsigned-message-len,
                    signed-payload-data(signed-payload),
                    signed-payload-size(signed-payload),
                    public-signing-key-data(public-key));
  as(<byte-string>, unsigned-message)
end method;