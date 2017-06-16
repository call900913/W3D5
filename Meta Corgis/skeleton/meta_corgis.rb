class SnackBox
  attr_reader :data

  SNACK_BOX_DATA = {
    1 => {
      "bone" => {
        "info" => "Phoenician rawhide",
        "tastiness" => 20
      },
      "kibble" => {
        "info" => "Delicately braised hamhocks",
        "tastiness" => 33
      },
      "treat" => {
        "info" => "Chewy dental sticks",
        "tastiness" => 40
      }
    },
    2 => {
      "bone" => {
        "info" => "An old dirty bone",
        "tastiness" => 2
      },
      "kibble" => {
        "info" => "Kale clusters",
        "tastiness" => 1
      },
      "treat" => {
        "info" => "Bacon",
        "tastiness" => 80
      }
    },
    3 => {
      "bone" => {
        "info" => "A steak bone",
        "tastiness" => 64
      },
      "kibble" => {
        "info" => "Sweet Potato nibbles",
        "tastiness" => 45
      },
      "treat" => {
        "info" => "Chicken bits",
        "tastiness" => 75
      }
    }
  }
  def initialize(data = SNACK_BOX_DATA)
    @data = data
  end

  def capitalized(string)
    string.capitalize!
  end



=begin
  def method_missing(method_name, arg)
    method_name = method_name.to_s
    type, descriptor = "a", "b"

    if method_name.start_with?("get_")
      attributes_string = method_name[4..-1]

      attributes_string.split("_").each.with_index do |attribute, idx|
        type = attribute if idx == 0
        descriptor = attribute if idx == 1
      end

    end

    @data[arg][type][descriptor]
  end
=end
  # def get_bone_info(box_id)
  #   @data[box_id]["bone"]["info"]
  # end
  #
  # def get_bone_tastiness(box_id)
  #   @data[box_id]["bone"]["tastiness"]
  # end
  #
  # def get_kibble_info(box_id)
  #   @data[box_id]["kibble"]["info"]
  # end
  #
  # def get_kibble_tastiness(box_id)
  #   @data[box_id]["kibble"]["tastiness"]
  # end
  #
  # def get_treat_info(box_id)
  #   @data[box_id]["treat"]["info"]
  # end
  #
  # def get_treat_tastiness(box_id)
  #   @data[box_id]["treat"]["tastiness"]
  # end
end


#contains a reference to the databse(an instance of SnackBox) AND its box_id in the databse.
#If we call bone, kibble, or treat on any instance of CorgiSnacks, we should get back a statemetn of the info and tastiness level of that snack.

class CorgiSnacks

  def initialize(snack_box, box_id)
    @snack_box = snack_box
    @box_id = box_id
  end

  def bone
    info = @snack_box.get_bone_info(@box_id)
    tastiness = @snack_box.get_bone_tastiness(@box_id)
    result = "Bone: #{info}: #{tastiness} "
    tastiness > 30 ? "* #{result}" : result
  end

  def kibble
    info = @snack_box.get_kibble_info(@box_id)
    tastiness = @snack_box.get_kibble_tastiness(@box_id)
    result = "Kibble: #{info}: #{tastiness} "
    tastiness > 30 ? "* #{result}" : result
  end

  def treat
    info = @snack_box.get_treat_info(@box_id)
    tastiness = @snack_box.get_treat_tastiness(@box_id)
    result = "Treat: #{info}: #{tastiness} "
    tastiness > 30 ? "* #{result}" : result
  end

end


class MetaCorgiSnacks
  def initialize(snack_box, box_id)
    @snack_box = snack_box
    @box_id = box_id
  end

  def method_missing(name, *args)
    # Your code goes here...
  end


  def self.define_snack(type)
    # Your code goes here...
    define_method(type) do
      puts "#{type}: #{@snack_box.data[@box_id][type]["info"]}: #{@snack_box.data[@box_id][type]["tastiness"]}"
    end

  end
end
