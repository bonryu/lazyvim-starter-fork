_G.br = {}

function br.python_extra_args()
  local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
  return { "--python-executable", virtual .. "/bin/python" }
end

function br.isempty(s)
  return s == nil or s == ""
end

function br.set_env()
  local conda_prefix = os.getenv("CONDA_PREFIX")
  if not br.isempty(conda_prefix) then
    -- vim.g.python_host_prog = conda_prefix .. "/bin/python"
    -- vim.g.python3_host_prog = conda_prefix .. "/bin/python"
    vim.env.VIRTUAL_ENV = conda_prefix
    vim.env.VENV_DIR = conda_prefix
    -- else
    --   vim.g.python_host_prog = "python"
    --   vim.g.python3_host_prog = "python3"
  end
end

br.notebookhint = [[
 _j_/_k_: move down/up    _r_: run
 _l_: run line            _R_: run
 ^^_<esc>_/_q_: exit
 ]]
