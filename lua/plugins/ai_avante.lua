if true then
  return {}
end
local openrouter_api_key = os.getenv("OPENROUTER_API_KEY")
local gemini_api_key = os.getenv("GEMINI_API_KEY")
-- local has_api_key = os.getenv("GEMINI_API_KEY") ~= nil
local has_api_key = false
local avante_provider = "openrouter" -- default provider
local rag_llm = {}
local rag_embed = {}

if openrouter_api_key ~= nil and openrouter_api_key ~= "" then
  has_api_key = true
  avante_provider = "openrouter"
  rag_llm = {
    provider = "openrouter",
    endpoint = "https://openrouter.ai/api/v1",
    api_key = "OPENROUTER_API_KEY",
    model = "cohere/command-r-plus-08-2024",
  }
  rag_embed = {
    provider = "openrouter",
    endpoint = "https://openrouter.ai/api/v1",
    api_key = "OPENROUTER_API_KEY",
    model = "cohere/embed-english-v3.0",
  }
elseif gemini_api_key ~= nil and gemini_api_key ~= "" then
  has_api_key = true
  avante_provider = "gemini"
  rag_llm = { -- Language Model (LLM) configuration for RAG service
    provider = "gemini",
    endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
    -- Injecting your secret directly
    -- api_key = _G.br.read_secret("default_gemini_api_key"),
    api_key = "GEMINI_API_KEY",
    model = "gemini-2.5-flash",
    extra = nil, -- Additional configuration options for LLM
  }
  rag_embed = { -- Embedding model configuration for RAG service
    provider = "gemini", -- Embedding provider
    endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
    api_key = "GEMINI_API_KEY", -- Environment variable name for the embedding API key
    model = "text-embedding-3-large", -- Embedding model name
    extra = nil, -- Additional configuration options for the embedding model
  }
end
-- local has_api_key = openrouter_api_key ~= nil

return {

  {
    "yetone/avante.nvim",
    enabled = false,
    -- Only load if we are in a folder that direnv has authorized
    -- cond = function()
    --   return os.getenv("GEMINI_API_KEY") ~= nil
    -- end,
    cond = has_api_key,
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    lazy = true,
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    -- @type avante.Config
    opts = {
      -- add any opts here
      -- this file can contain specific instructions for your project
      instructions_file = "avante.md",
      -- for example
      provider = avante_provider,
      providers = {
        gemini = {
          -- Use your existing secret reader
          api_key_name = "GEMINI_API_KEY", -- Avante can read from ENV or you can pass the string
          model = "gemini-2.5-flash",
          timeout = 30000, -- 30s
          temperature = 0,
          max_tokens = 4096,
        },
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4-20250514",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 20480,
          },
        },
        moonshot = {
          endpoint = "https://api.moonshot.ai/v1",
          model = "kimi-k2-0711-preview",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 32768,
          },
        },
        openrouter = {
          __inherited_from = "openai",
          endpoint = "https://openrouter.ai/api/v1",
          -- FIX 2: Swapped api_key_name for api_key to satisfy custom providers
          api_key_name = "OPENROUTER_API_KEY",
          -- model = "cohere/command-r-plus-08-2024",
          -- model = "anthropic/claude-4.6-sonnet",
          -- model = "google/gemini-2.5-flash",
          model = "deepseek/deepseek-chat",
          timeout = 30000,
          extra_request_body = {
            temperature = 0,
            max_tokens = 4096,
          },
        },
      },

      -- This enables the background indexing service
      rag_service = { -- RAG Service configuration
        -- Only enable if we actually have a key to power it
        enabled = has_api_key, -- Enables the RAG service
        host_mount = os.getenv("HOME") .. "/ai_workspace", -- Host mount path for the rag service (Docker will mount this path)
        runner = "docker", -- Runner for the RAG service (can use docker or nix)

        llm = rag_llm,
        embed = rag_embed,
        docker_extra_args = "", -- Extra arguments to pass to the docker command
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-mini/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim", -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
