local actions = require "telescope.actions"
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values
local entry_display = require "telescope.pickers.entry_display"
local action_state = require "telescope.actions.state"

function path_to_display_name(file, target_path)
  path_without_prefix = file:sub(#target_path + 1)
  path_without_prefix_without_extension = path_without_prefix:sub(1, -4)
  return path_without_prefix_without_extension
end

local displayer = entry_display.create {
  separator = " ",
  items = {
    { width = 40 },
    { remaining = true },
  },
}

local make_display = function(table)
  return displayer {
    table.ordinal,
  }
end

local find_rails = function(target, target_path, opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = target,
    finder = finders.new_oneshot_job({
      "find",
      target_path,
      "-type",
      "f",
    }, {
      entry_maker = function(file)
        local path_without_prefix = path_to_display_name(file, target_path)
        return {
          value = file,
          display = function(table)
            return make_display(table)
          end,
          ordinal = path_without_prefix,
          path = file,
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
  }):find()
end

local find_models = function(opts)
  find_rails("models", "app/models/", opts)
end

local find_controllers = function(opts)
  find_rails("controllers", "app/controllers/", opts)
end

local find_specs = function(opts)
  find_rails("specs", "spec", opts)
end

return require("telescope").register_extension {
  exports = {
    models = find_models,
    controllers = find_controllers,
    specs = find_specs,
  },
}
