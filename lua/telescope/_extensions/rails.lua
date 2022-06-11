local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")
local action_state = require("telescope.actions.state")

local flatten = vim.tbl_flatten

local find_rails = function(target, opts)
  opts = opts or {}
  local path = "app/" .. target .. "/"
  pickers.new(opts, {
    prompt_title = target,
    finder = finders.new_oneshot_job({
      "find", path, "-type", "f",
      entry_maker = function(entry)
        return {
          value = "hoge",
          -- display = entry[1],
          display = "hoge",
          ordinal = entry[1],
        }
      end
    }),
    sorter = conf.generic_sorter(opts),
    -- attach_mappings = function(prompt_bufnr, map)
    --   actions.select_default:replace(function()
    --     actions.close(prompt_bufnr)
    --     local selection = action_state.get_selected_entry()
    --     -- print(vim.inspect(selection))
    --     vim.api.nvim_put({ selection[1] }, "", false, true)
    --   end)
    --   return true
    -- end,
  }):find()
end

local find_models = function(opts)
  find_rails("models", opts)
end

local find_controllers = function(opts)
  find_rails("controllers", opts)
end

return require("telescope").register_extension({
  exports = {
    models = find_models,
    controllers = find_controllers,
  },
})
