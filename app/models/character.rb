class Character
  include MongoMapper::Document
  one :alignment
  
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
  validate :level_range

  def level_range
    if self.level > 20
      errors.add( :level, "20 Is the highest level this genrator supports")
    elsif self.level < 1
      self.errors.add( :level, "You can not go below 1st level")
    end
  end

  before_create do
    self.attach_alignment
  end

  before_save do
    self.initalize_status_and_step if self.new?
    self.experince = Chart.convert_experince(self.experince, 'exp') if self.level_changed?
    self.level = Chart.convert_experince(self.level, 'level') if self.experince_changed?
    self.set_status
    self.set_next_step
  end

  def increase_level
    self.level += 1
  end

  def decrease_level
    self.level -= 1
  end

  def attach_alignment
    self.alignment = Alignment.new()
  end

  timestamps!
  key :name
  key :experince, default: 0
  key :level, default: 1
  key :death_save_successes, default: -1
  key :death_save_failures, default: -1
  key :initative
  key :speed
  key :proficiency_bonus
  key :status
  key :status_details
  key :next_step

  def initalize_status_and_step
    self.status = {
      #player: false,
      name: false,
      #race: false,
      level: false,
      proficiency: false,
      #classes: false,
      #background: false,
      #abilities: false,
      #skills:false,
      #hitpoints: false,
      alignment: false,
      initative: false,
      speed: false
    }
    self.next_step = 'name'
  end

  def set_status
    nonemeds = ["name", "level", "proficiency", "initative", "speed"]
    self.status.each do |key, value|
      if nonemeds.include?(key.to_s)
        debugger
        self.status[key] = self[key].present? ? true : false
      else
        unless self.new_record?
          debugger
          self.status[key.to_s] = self.send(key.to_s).complete?
        end
      end
    end
  end

  def set_next_step
    was_set = false
    self.status.each do |key, value|
      if value == false
        self.next_step = key.to_s
        was_set = true
        break
      end
    end
    self.next_step = null unless was_set
  end
end

