module: libsodium
synopsis: bindings for the sodium library
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define simple-C-mapped-subtype <C-buffer-offset> (<C-void*>)
  export-map <machine-word>, export-function: identity;
end;

define interface
  #include {
      "sodium.h",
      "sodium/core.h",
      "sodium/crypto_aead_aes256gcm.h",
      "sodium/crypto_aead_chacha20poly1305.h",
      "sodium/crypto_auth.h",
      "sodium/crypto_auth_hmacsha256.h",
      "sodium/crypto_auth_hmacsha512.h",
      "sodium/crypto_auth_hmacsha512256.h",
      "sodium/crypto_box.h",
      "sodium/crypto_box_curve25519xsalsa20poly1305.h",
      "sodium/crypto_core_hsalsa20.h",
      "sodium/crypto_core_salsa20.h",
      "sodium/crypto_core_salsa2012.h",
      "sodium/crypto_core_salsa208.h",
      "sodium/crypto_generichash.h",
      "sodium/crypto_generichash_blake2b.h",
      "sodium/crypto_hash.h",
      "sodium/crypto_hash_sha256.h",
      "sodium/crypto_hash_sha512.h",
      "sodium/crypto_onetimeauth.h",
      "sodium/crypto_onetimeauth_poly1305.h",
      "sodium/crypto_pwhash_scryptsalsa208sha256.h",
      "sodium/crypto_scalarmult.h",
      "sodium/crypto_scalarmult_curve25519.h",
      "sodium/crypto_secretbox.h",
      "sodium/crypto_secretbox_xsalsa20poly1305.h",
      "sodium/crypto_shorthash.h",
      "sodium/crypto_shorthash_siphash24.h",
      "sodium/crypto_sign.h",
      "sodium/crypto_sign_ed25519.h",
      "sodium/crypto_sign_edwards25519sha512batch.h",
      "sodium/crypto_stream.h",
      "sodium/crypto_stream_aes128ctr.h",
      "sodium/crypto_stream_chacha20.h",
      "sodium/crypto_stream_salsa20.h",
      "sodium/crypto_stream_salsa2012.h",
      "sodium/crypto_stream_salsa208.h",
      "sodium/crypto_stream_xsalsa20.h",
      "sodium/crypto_verify_16.h",
      "sodium/crypto_verify_32.h",
      "sodium/crypto_verify_64.h",
      "sodium/randombytes.h",
      "sodium/randombytes_salsa20_random.h",
      "sodium/randombytes_sysrandom.h",
      "sodium/runtime.h",
      "sodium/utils.h",
      "sodium/version.h"
    },
    import: all,
    inline-functions: inline,
    map: { "unsigned char*" => <C-buffer-offset> },
    exclude: {
      "_crypto_generichash_blake2b_pick_best_implementation",
      "_crypto_onetimeauth_poly1305_pick_best_implementation",
      "_crypto_scalarmult_curve25519_pick_best_implementation",
      "_crypto_stream_chacha20_pick_best_implementation",
      "_sodium_alloc_init",
      "_sodium_runtime_get_cpu_features",
      "crypto_sign_edwards25519sha512batch_bytes",
      "crypto_sign_edwards25519sha512batch_publickeybytes",
      "crypto_sign_edwards25519sha512batch_secretkeybytes",
      "randombytes_salsa20_implementation",
      "randombytes_sysrandom_implementation"
    };

    function "crypto_auth" => %crypto-auth;
    function "crypto_auth_verify" => %crypto-auth-verify;
    function "crypto_auth_hmacsha256" => %crypto-auth-hmacsha256;
    function "crypto_auth_hmacsha256_verify" => %crypto-auth-hmacsha256-verify;
    function "crypto_auth_hmacsha512" => %crypto-auth-hmacsha512;
    function "crypto_auth_hmacsha512_verify" => %crypto-auth-hmacsha512-verify;
    function "crypto_auth_hmacsha512256" => %crypto-auth-hmacsha512256;
    function "crypto_auth_hmacsha512256_verify" => %crypto-auth-hmacsha512256-verify;
    function "crypto_sign_keypair" => %crypto-sign-keypair;
    function "crypto_sign_ed25519_keypair" => %crypto-sign-ed25519-keypair;
    function "crypto_sign_ed25519_sk_to_pk" => %crypto-sign-ed25519-sk-to-pk;
    function "crypto_sign" => %crypto-sign;
    function "crypto_sign_open" => %crypto-sign-open;
    function "crypto_sign_detached" => %crypto-sign-detached;
    function "crypto_sign_verify_detached" => %crypto-sign-verify-detached;
    function "crypto_sign_ed25519" => %crypto-sign-ed25519;
    function "crypto_sign_ed25519_open" => %crypto-sign-ed25519-open;
    function "crypto_sign_ed25519_detached" => %crypto-sign-ed25519-detached;
    function "crypto_sign_ed25519_verify_detached" => %crypto-sign-ed25519-verify-detached;
end interface;
