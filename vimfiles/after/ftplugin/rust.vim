function! s:detect_project_type_for_rust() abort
  silent call system('cargo check')
  let b:quickrun_config = {}
  if v:shell_error == 0
    let b:quickrun_config.type = "rust/cargo"
  endif
endfunction

call s:detect_project_type_for_rust()
