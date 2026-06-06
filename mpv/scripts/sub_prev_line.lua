-- sub_prev_line.lua
-- Show previous subtitle line above current line (OSD overlay).
-- Works for text-based subtitles (SRT/ASS text). Image-based subs won't work.

local mp = require "mp"
local last = ""
local cur = ""

-- Basic rendering options
local opts = {
    lines = 2,            -- 2 = previous + current
    duration = 3600,      -- seconds; keep it effectively persistent while playing
    max_chars = 3000,     -- safety
}

local function sanitize(s)
    if not s then return "" end
    -- mpv sub-text may include \N line breaks; normalize to real newlines
    s = s:gsub("\\N", "\n")
    -- Trim
    s = s:gsub("^%s+", ""):gsub("%s+$", "")
    -- Limit size
    if #s > opts.max_chars then
        s = s:sub(1, opts.max_chars)
    end
    return s
end

local function render()
    local parts = {}
    if opts.lines >= 2 and last ~= "" then
        table.insert(parts, last)
    end
    if cur ~= "" then
        table.insert(parts, cur)
    end
    local msg = table.concat(parts, "\n")
    -- OSD message persists; will refresh on subtitle changes/pauses
    mp.osd_message(msg, opts.duration)
end

local function on_sub_change(_, value)
    local s = sanitize(value)
    if s == "" then
        -- When subtitle disappears, keep current display; do not blank immediately
        return
    end
    -- Avoid duplicates from repeated observe callbacks
    if s == cur then return end

    last = cur
    cur = s
    render()
end

-- Update when subtitle changes
mp.observe_property("sub-text", "string", on_sub_change)

-- Also refresh on pause/unpause/seeks so the overlay doesn't vanish
mp.observe_property("pause", "bool", function() render() end)
mp.register_event("seek", function() render() end)
mp.register_event("file-loaded", function()
    last = ""
    cur = sanitize(mp.get_property("sub-text"))
    render()
end)

