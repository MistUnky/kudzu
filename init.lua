ENABLE_KUDZU_BIOME = core.settings:get_bool("enable_kudzu_biome", false)
ENABLE_KUDZU_CRAFT = core.settings:get_bool("enable_kudzu_craft", false)
ENABLE_FOOD_CRAFT  = core.settings:get_bool("enable_kudzu_food_craft", true)
ENABLE_OTHER_CRAFT = core.settings:get_bool("enable_kudzu_other_craft", true)

core.register_node("kudzu:kudzu", {
	description = "Kudzu",
	tiles = {"kudzu_kudzu.png"},
	light_source = 1,
	paramtype = "light",
	groups = {snappy = 3, flammable = 2, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
})

if ENABLE_FOOD_CRAFT then
	core.register_craftitem("kudzu:tea", {
		description = "Kudzu Tea",
		inventory_image = "kudzu_tea.png",
		on_use = function(itemstack, user, pointed_thing)
			if user then
				return core.do_item_eat(1, "vessels:drinking_glass", itemstack, user, pointed_thing)
			end
		end
	})

	core.register_craftitem("kudzu:soup", {
		description = "Kudzu Soup",
		inventory_image = "kudzu_soup.png",
		on_use = function(itemstack, user, pointed_thing)
			if user then
				return core.do_item_eat(3, "vessels:drinking_glass", itemstack, user, pointed_thing)
			end
		end
	})

	core.register_craftitem("kudzu:jelly", {
		description = "Kudzu Jelly",
		inventory_image = "kudzu_jelly.png",
		on_use = function(itemstack, user, pointed_thing)
			if user then
				return core.do_item_eat(6, "vessels:drinking_glass", itemstack, user, pointed_thing)
			end
		end
	})

	core.register_craft({
		output = "kudzu:tea",
		recipe = {
			{"kudzu:kudzu", "kudzu:kudzu", "kudzu:kudzu"},
			{"kudzu:kudzu", "bucket:bucket_river_water", "kudzu:kudzu"},
			{"", "vessels:drinking_glass", ""},
		},
		replacements = {{"bucket:bucket_river_water", "bucket:bucket_empty"}},
	})

	core.register_craft({
		type = "cooking",
		output = "kudzu:soup",
		recipe = "kudzu:tea",
		cooktime = 10,
	})

	core.register_craft({
		type = "cooking",
		output = "kudzu:jelly",
		recipe = "kudzu:soup",
		cooktime = 20,
	})

end


if ENABLE_OTHER_CRAFT then
	core.register_craftitem("kudzu:sticks", {
		description = "Kudzu Sticks",
		inventory_image = "kudzu_sticks.png",
		groups = {flammable = 2},
	})

	core.register_craft({
		output = "kudzu:sticks",
		recipe = {
			{"kudzu:kudzu", "kudzu:kudzu", "kudzu:kudzu"},
			{"kudzu:kudzu", "kudzu:kudzu", "kudzu:kudzu"},
			{"kudzu:kudzu", "kudzu:kudzu", "kudzu:kudzu"},
		}
	})

	core.register_craft({
		type = "cooking",
		output = "default:stick",
		recipe = "kudzu:sticks",
		cooktime = 5,
	})

	core.register_craft({
		output = "kudzu:ladder",
		recipe = {
			{"kudzu:sticks", "kudzu:sticks", "kudzu:sticks"},
			{"kudzu:sticks", "kudzu:sticks", "kudzu:sticks"},
			{"kudzu:sticks", "kudzu:sticks", "kudzu:sticks"},
		}
	})
end

core.register_node("kudzu:ladder", {
	description = "Kudzu Ladder",
	drawtype = "signlike",
	tiles = {"kudzu_ladder.png"},
	inventory_image = "kudzu_ladder.png",
	wield_image = "kudzu_ladder.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = {snappy = 3, flammable = 2},
	legacy_wallmounted = true,
	sounds = default.node_sound_leaves_defaults(),
})

core.register_on_mods_loaded(function()
	for node_name, node_definition in pairs(core.registered_nodes) do
		if not (node_name == "ignore" or node_name == nil or node_name == "" or node_name == "air" or node_name == "kudzu:kudzu" or node_name == "fire:basic_flame") then
			local g = table.copy(node_definition.groups)
			g.sus = 1
			core.override_item(node_name,{
				groups = g
			})
		end
	end
end)

core.register_abm({
	nodenames = {"air"},
	neighbors = {"group:sus"},
	interval = 1,
	chance = 16^2,
	action = function(pos)
		if core.find_node_near(pos, 1, {"kudzu:kudzu"}) ~= nil then
			core.set_node(pos, {name="kudzu:kudzu"})
		end
	end
})

if ENABLE_KUDZU_BIOME then
	core.register_biome({
		node_top = "kudzu:kudzu",
		depth_top = 1,
		node_filler = "default:dirt",
		depth_filler = 2,
		y_min = -31000,
		y_max = 31000,
		heat_point = 50,
		humidity_point = 75,
	})
end

if ENABLE_KUDZU_CRAFT then
	core.register_craft({
		output = "kudzu:kudzu",
		recipe = {
			{"default:junglegrass", "default:mese", "default:junglegrass"},
			{"default:mese", "bucket:bucket_water", "default:mese"},
			{"default:junglegrass", "default:mese", "default:junglegrass"},
		},
		replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
	})
end
