_G.br = {}

function br.python_extra_args()
  local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
  return { "--python-executable", virtual .. "/bin/python" }
end
