#
# "The Defeat at Procyon V"
# Chris Pressey, Cat's Eye Technologies
# for NaNoGenMo 2018
#


#
# General Utility
#


function capfirst(s)
    titlecase(s[1]) * s[2:length(s)]
end

function whittleDownSet(s, thresh)
    Set([x for x=s if rand() <= thresh])
end

#
# Weapons
#


A = [
  "quantum",
  "positronic",
  "long range",
  "supercharged",
  "armor-piercing",
  "nuclear",
  "composite",
  "guided",
  "stealth",
  "atomic",
  "subatomic",
  "superconducting",
  "heat-seeking",
]

B = [
  "destructo",
  "electron",
  "neutron",
  "positron",
  "neutrino",
  "gluon",
  "assault",
  "frag",
  "photon",
  "graviton",
  "warp",
  "wavelet",
  "disruptor",
  "laser",
  "plasma",
  "muon",
  "antimatter",
  "hyperspace",
]


C = [
  "laser",
  "ray",
  "beam",
  "bomb",
  "torpedo",
  "missile",
  "disruptor",
  "cannon",
  "rocket",
  "blaster",
  "bomb",
]

allWeapons = Set(["$(a) $(b) $(c)" for a=A, b=B, c=C])
#allWeapons = whittleDownSet(allWeapons, 0.80)
lastWeapon = ""

function goodWeapon(w)
    return (
        (!occursin("laser laser", w)) &&
        (!occursin("disruptor disruptor", w)) &&
        (!occursin("photon torpedo", w)) &&
        (!occursin("positronic positron", w))
    )
end

function weapon()
    global lastWeapon
    w = rand(allWeapons)
    while !goodWeapon(w)
        delete!(allWeapons, w)
        w = rand(allWeapons)
    end
    delete!(allWeapons, w)
    lastWeapon = w
    return w
end

function addToColumnA(a)
    global A, allWeapons
    newWeapons = Set(["$(a) $(b) $(c)" for b=B, c=C])
    newWeapons = whittleDownSet(newWeapons, 0.5)
    union!(allWeapons, newWeapons)
    push!(A, a)
end

function addToColumnB(b)
    global B, allWeapons
    newWeapons = Set(["$(a) $(b) $(c)" for a=A, c=C])
    newWeapons = whittleDownSet(newWeapons, 0.5)
    union!(allWeapons, newWeapons)
    push!(B, b)
end

function addToColumnC(c)
    global C, allWeapons
    newWeapons = Set(["$(a) $(b) $(c)" for a=A, b=B])
    newWeapons = whittleDownSet(newWeapons, 0.5)
    union!(allWeapons, newWeapons)
    push!(C, c)
end


#
# Incidental Actions
#


acts = Dict(
    (   3, "S") => " leaned back in her chair.  ",
    (1000, "S") => " opened the drawer of her desk.  ",
    (1001, "S") => " took a pack of biscuits out of the drawer and placed it on the desk.  ",
    (1002, "S") => " opened the pack of biscuits.  ",
    (1003, "S") => " took a biscuit out of the pack.  ",
    (1004, "S") => " took a bite out of the biscuit.  ",
    (1005, "S") => " finished the biscuit.  ",
    (1006, "S") => " brushed some crumbs off her uniform.  ",
    (1007, "S") => " slid the pack across the desk towards Fleet Commander Ng.  ",
    (1007, "N") => " made a small refusal gesture in the direction of the biscuits.  ",
    (1008, "S") => " gave the Fleet Commander a tight-lipped smile and made a repeated lifting motion.  ",
    (1008, "N") => " struck a vaguely conciliatory pose and took a biscuit.  ",
    (1009, "S") => " put the biscuits back in the desk drawer.  ",
    (1500, "N") => " suddenly remembered he was holding a biscuit, and took a bite out of it.  ",
    (1100, "W") => "supersymmetric/tachyon/lance",
    (1200, "W") => "electro/compression/warhead",
    (1300, "W") => "immolating/napalm/grenade",
    (1400, "W") => "isomorphic/destabilizer/cluster",
    (1500, "W") => "combinatorial/tensor field/charge",
    (1600, "W") => "non-commutative/hyperbole/caltrop",
)


#
# Generation
#

function exchange(n)
    if haskey(acts, (n, "S"))
        print("Super Admiral O’James" * acts[(n, "S")])
    end

    theirw = lastWeapon
    ourw = weapon()
    (commander_say, say_context) = rand([
        ("So we responded with our $(ourw)s, I presume?",        "used"),
        ("Surely our $(ourw)s would be able to fend those off.", "used"),
        ("But we had $(ourw)s, didn't we?",                      "had"),
        ("Did we not have $(ourw)s to counter with?",            "had"),
        ("Were we not equipped with $(ourw)s?",                  "had"),
        ("What about our $(ourw)s?",                             "what"),
    ])

    if n == 1
        (commander_say, say_context) = ("$(capfirst(theirw))s? Could we not counter those with our $(ourw)s?", "used")
    end

    println("“" * commander_say * "”")
    println("")

    if haskey(acts, (n, "N"))
        print("Fleet Commander Ng" * acts[(n, "N")])
    end

    theirw = weapon()

    sub_respond = rand([
        "Yes!",
        "Yes, just so!",
        "Of course!",
        "Absolutely!",
        "Just as our training dictates!",
    ])

    sub_say = rand([
        "But the enemy neutralized them with their $(theirw)s.",
        "But it turned out they also had $(theirw)s.",
        "But to our surprise they were equipped with $(theirw)s.",
        "But these were not sufficient against their $(theirw)s.",
        "Alas, these were no match for their $(theirw)s.",
        "However, they counter-attacked with $(theirw)s.",
    ])

    if say_context == "used"
        # pass
    elseif say_context == "had"
        sub_respond = rand([
            "Yes!",
            "Yes, just so!",
            "Of course!",
            "Absolutely!",
            "A full complement!",
            "In spades!",
        ])
    elseif say_context == "what"
        sub_respond = rand([
            "That was our immediate response!",
            "We deployed them immediately!",
            "Absolutely we used those!",
            "Those were just what we responded with!",
        ])
    end

    println("“" * sub_respond * "  " * sub_say * "”")
    println("")

    if haskey(acts, (n, "W"))
        parts = split(acts[(n, "W")], "/")
        addToColumnA(parts[1])
        addToColumnB(parts[2])
        addToColumnC(parts[3])
    end

end

function main()
    global allWeapons

    fweap = weapon()

    println("""
    # The Defeat at Procyon V
    
    _Being an Episode in the Later Career of Super Admiral Serenity O’James of the Space Fighters_
    
    ## Chapter 1
    
    Fleet Commander Dmitry Ng stood at attention before the desk of Super Admiral Serenity O’James
    and saluted.
    
    “At ease, Ng,” she mumbled, not looking up from her paperwork.  “What is it?”
    
    “Ma’am, I regret to inform you that the units of 19th Squadron 8th Division have failed
    to hold our outpost at Procyon V.  The enemy staged a surprise attack in full force with
    a barrage of $(fweap)s.”
    
    Serenity O’James turned her eyes upward to the Fleet Commander and frowned.
    """)

    n = 1
    while length(allWeapons) > 1
        exchange(n)
        n = n + 1
    end

    println("""
    Serenity O’James was silent for a long moment.  Finally, she let out a low whistle.
    “$(capfirst(lastWeapon))s, huh.”
    
    “Yes, ma’am,” responded the Fleet Commander efficiently.
    
    “That’s... unfortunate.”

    “Yes, ma’am.”  What else was there to say?
    
    “Well. Well, well, well. Well, I suppose the way is open for them to send their fleet
    straight to Tau Ceti, now.  But at least they still have no idea where our key base is hidden.”
    
    “Very true, Super Admiral.  That information is safe and sound in our unbreachable
    data network.  They will never locate our key base!”
    
    ## Chapter 2
    
    Meanwhile, unbeknownst to these two, a thousand parsecs away, two young Cyber Sappers
    were jacked in to the Space Fighters’ main combat mainframe.
    
    “Deploy the modular corruptor exploit!”
    
    “Deployed. Alert! They've responded with a crypto honeypot virus!”
    
    “Ah, but they haven't counted on our modular decompiler zero-day...”
    
    <center>_THE END(?)_</center>
    """)
end

#
# Entry Point
#

main()
