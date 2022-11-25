minetest.register_node("kudzu:kudzu", {
	description = "Kudzu",
	tiles = {"kudzu_kudzu.png"},
	light_source = 1,
	paramtype = "light",
	groups = {snappy = 3, flammable = 2, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("kudzu:sticks", {
	description = "Kudzu Sticks",
	inventory_image = "kudzu_sticks.png",
	groups = {flammable = 2},
})

minetest.register_node("kudzu:ladder", {
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

minetest.register_on_mods_loaded(function()
	for node_name, node_definition in pairs(minetest.registered_nodes) do
		if not (node_name == "ignore" or node_name == nil or node_name == "" or node_name == "air" or node_name == "kudzu:kudzu" or node_name == "fire:basic_flame") then
			local g = table.copy(node_definition.groups)
			g.sus = 1
			minetest.override_item(node_name,{
				groups = g
			})
		end
	end
end)

minetest.register_abm({
	nodenames = {"air"},
	neighbors = {"group:sus"},
	interval = 1,
	chance = 16^2,
	action = function(pos)
		if minetest.find_node_near(pos, 1, {"kudzu:kudzu"}) ~= nil then
			minetest.set_node(pos, {name="kudzu:kudzu"})
		end
	end
})

minetest.register_craft({
	output = "kudzu:sticks",
	recipe = {
		{"kudzu:kudzu", "kudzu:kudzu", "kudzu:kudzu"},
		{"kudzu:kudzu", "kudzu:kudzu", "kudzu:kudzu"},
		{"kudzu:kudzu", "kudzu:kudzu", "kudzu:kudzu"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "default:stick",
	recipe = "kudzu:sticks",
	cooktime = 5,
})

minetest.register_craft({
	output = "kudzu:ladder",
	recipe = {
		{"kudzu:sticks", "kudzu:sticks", "kudzu:sticks"},
		{"kudzu:sticks", "kudzu:sticks", "kudzu:sticks"},
		{"kudzu:sticks", "kudzu:sticks", "kudzu:sticks"},
	}
})
