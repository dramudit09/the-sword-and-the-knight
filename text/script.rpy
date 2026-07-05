# The script of the game goes in this file.

# Declare characters used by this game. The color argument colorizes the
# name of the character.
define s = Character("Sword")
define k = Character("Knight")

# The game starts here.

label start:

	# Show a background. This uses a placeholder by default, but you can
	# add a file (named either "bg room.png" or "bg room.jpg") to the
	# images directory to show it.

	scene bg room

	# This shows a character sprite. A placeholder is used, but you can
	# replace it by adding a file named "eileen happy.png" to the images
	# directory.
	show sword
	show knight

	# These display lines of dialogue.

	e "Did you change the name and save directory of the game in options.rpy?"
	k "I’m so tired..."
	s "Rough day?"
	k "Rough life. But yes, today has been … eventful"
	s "Events end, do they not?"
	menu:
		"What do you fear?"
		"I fear the end":
			call fear_the_end
		"I fear my end":
			call fear_my_end
	s "Not me. I am but a tool. Used and discarded, but never truly able to end."
	k "All this talk about ends..."
	s "..."
	s "So, what’s the plan?"
	k "Plan?"
	s "Heroes always have a plan."
	menu: 
		"Heh. I’m all out.":
			call all_out
		"Heroes wouldn’t be hiding while the world burns.":
			call world_burn
		
	s "Oh. I see. So you’ve given up, right?"
	k "Given up? Don’t try to bait me, dear sword."
	s "Bait only works if there’s something there to catch. I simply meant to ask what you meant by 'all out'."
	k "I’m all out of ideas. All out of allies. All out of energy. All out of blood pretty soon. All out of..."
	s "..."
	k "I just wanted to see the moon one last time. Know the peace of night one last time. Perhaps have a conversation with a nonsensical sentient sword."
	s "What if this sentient sword had some ideas?"
	k "Ah, there’s the bait again. Last minute saviors are a thing of fairytales. Or perhaps nightmares?"
	s "One person’s fairytale is another person’s nightmare."
	k "Ah but both are dreams. Hmm... dreams..."
	s "Well then..."
	s "A dead hero can’t save the world."
	k "It sounds like you’ve got a plan. Does that make you a hero?"
	s "Not a hero. But perhaps the tool to change fate."
	k "How do you mean that?"

	s "I am a legendary sword, wielded by heroes to alter the course of entire wars, even civilizations. My blade makes my wielder an unstoppable force, rendering ti"
	k "How lucky of me."
	
	return

label fear_the_end: 
	s "The end of what? The end of this battle? The end of this war? Your own end?"
	k "I don’t even know anymore. Does it have to be one or the other?"
	s "Everything ends."
	k "You end?"
	return

label fear_my_end:
	s "Your end?"
	k "Our side was always fated to lose."
	s "Is fate not what you make of it?"
	k "Posh words for a thing made to bring death."
	return
	
label all_out:
	s "TODO"
	return

label world_burn:
	s "TODO"
	return
