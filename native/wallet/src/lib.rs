extern crate libc;

use libc::c_char;
use std::ffi::CString;

pub fn hello() -> *mut c_char {
    let c_str_song = CString::new("Hello world").unwrap();
    c_str_song.into_raw()
}

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
