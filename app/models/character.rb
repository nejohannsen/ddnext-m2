class Character
  include MongoMapper::Document
  #Embed:
  # Player: Name, DCI
  # Classes: ...
  # Race: ...
  # Background: ...
  # Faction: ...
  # Abilities
  # Skills   key :skill_acrobatics, default: -1, key :skill_animal_handling, default: -1, key :skill_arcana, default: -1, key :skill_athletics, default: -1,  
  #          key :skill_deception, default: -1, key :skill_history, default: -1, key :skill_insight, default: -1, key :skill_intimidation, default: -1, 
  #          key :skill_investigation, default: -1, key :skill_medicine, default: -1, key :skill_nature, default: -1, key :skill_percepion, default: -1, 
  #          key :skill_performance, default: -1, key :skill_persuasion, default: -1, key :skill_religion, default: -1, key :skill_sleight_of_hand, default: -1, 
  #          key :skill_stealth, default: -1, key :skill_survival, default: -1,
  # HitPoints:   key :hit_dice, key :hit_points, key :current_hit_points, key :temp_hit_points
  # ArmorClass: ...
  # Traits:   key :personality_traits, key :ideals, key :bonds, default: '', key :flaws




  timestamps!
  key :name
  key :alignment
  key :experince_points, default: 0
  key :level, default: 1
  key :death_save_successes, default: -1
  key :death_save_failures, default: -1
  key :initative, default: -1
  key :speed, default: 30
  key :proficiency_bonus, default: 2

end

