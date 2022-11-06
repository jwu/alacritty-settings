-- update console title
----------------------------------------

function starship_preprompt_user_func(prompt)
  local cwd = os.getcwd()
  local prj = path.getname(cwd)
  if prj == '' then
    prj = ''
  else
    prj = '['..prj..'] '
  end

  console.settitle(prj..cwd)
end

-- use starship for prompt
----------------------------------------

local starship_exe = clink.get_env('AL_VENDOR')..'/starship'
load(io.popen(starship_exe..' init cmd'):read("*a"))()

-- use clink_completions for completions
----------------------------------------

local completions_dir = clink.get_env('AL_VENDOR')..'/clink_completions/'

-- Execute '.init.lua' first to ensure package.path is set properly
dofile(completions_dir..'.init.lua')

for _,lua_module in ipairs(clink.find_files(completions_dir..'*.lua')) do
  -- Skip files that starts with _. This could be useful if some files should be ignored
  if not string.match(lua_module, '^_.*') then
    local filename = completions_dir..lua_module
    -- use dofile instead of require because require caches loaded modules
    -- so config reloading using Alt-Q won't reload updated modules.
    dofile(filename)
  end
end
