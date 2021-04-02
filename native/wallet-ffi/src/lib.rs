extern crate libc;

use libc::c_char;

#[no_mangle]
pub extern "C" fn hello() -> *mut c_char {
    wallet::hello()
}
