# == Schema Information
# Schema version: 20110328162454
#
# Table name: hartman_value_profiles
#
#  id               :integer         not null, primary key
#  taken_at         :datetime
#  user_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  dif_v            :integer
#  dim_i_v          :integer
#  dim_e_v          :integer
#  dim_s_v          :integer
#  int_v            :integer
#  int_i_v          :integer
#  int_e_v          :integer
#  int_s_v          :integer
#  dim_v            :integer
#  di_v             :integer
#  dis_v            :integer
#  dim_percent_v    :float
#  int_percent_v    :float
#  positive_i_v     :integer
#  positive_e_v     :integer
#  positive_s_v     :integer
#  positive_total_v :integer
#  negative_i_v     :integer
#  negative_e_v     :integer
#  negative_s_v     :integer
#  negative_total_v :integer
#  ai_percent_v     :float
#  dif_s            :integer
#  dim_i_s          :integer
#  dim_e_s          :integer
#  dim_s_s          :integer
#  int_s            :integer
#  int_i_s          :integer
#  int_e_s          :integer
#  int_s_s          :integer
#  dim_s            :integer
#  di_s             :integer
#  dis_s            :integer
#  dim_percent_s    :float
#  int_percent_s    :float
#  positive_i_s     :integer
#  positive_e_s     :integer
#  positive_s_s     :integer
#  positive_total_s :integer
#  negative_i_s     :integer
#  negative_e_s     :integer
#  negative_s_s     :integer
#  negative_total_s :integer
#  ai_percent_s     :float
#  vq_left          :integer
#  vq_right         :integer
#  sq_left          :integer
#  sq_right         :integer
#  bqr1             :float
#  bqa1             :float
#  bqr2             :float
#  bqa2             :float
#  cq1              :float
#  cq2              :float
#  dif1_over_dif2   :float
#

class HartmanValueProfile < ActiveRecord::Base
  # none of the elements of this model should be editable from the web
#  attr_accessible

  # set-up user and hvp_elements associations
  belongs_to :user
  has_many :hvp_elements
  # enable forms for hartman value profile to show hvp_elements
  # in forms.
  accepts_nested_attributes_for :hvp_elements

#  before_save :set_dim_i

  # validations
  validates :taken_at, :presence => true
  validates :user_id, :presence => true

  # order the tests to that the newest is displayed first
  default_scope :order => 'hartman_value_profiles.taken_at DESC'

  def score_profile
    self.dim_i_v, self.int_i_v, self.positive_i_v, self.negative_i_v = 
      calc_dim_and_int("intrinsic", "world")
    self.dim_e_v, self.int_e_v, self.positive_e_v, self.negative_e_v = 
      calc_dim_and_int("extrinsic", "world")
    self.dim_s_v, self.int_s_v, self.positive_s_v, self.negative_s_v = 
      calc_dim_and_int("systemic", "world")
    self.dif_v = self.dim_i_v + self.dim_e_v + self.dim_s_v
    self.int_v = self.int_i_v + self.int_e_v + self.int_s_v
    self.dim_v = 3 * [self.dim_i_v, self.dim_e_v, self.dim_s_v].max - 
      self.dim_i_v - self.dim_e_v - self.dim_s_v
    self.di_v = 3 * [self.int_i_v, self.int_e_v, self.int_s_v].max -
      self.int_i_v - self.int_e_v - self.int_s_v
    self.dis_v = calc_dis("world")
    self.vq_left = self.dif_v + self.dim_v + self.int_v + self.dis_v
    self.vq_right = self.dim_v + self.int_v + self.dis_v
    self.positive_total_v = 
      self.positive_i_v + self.positive_e_v + self.positive_s_v
    self.negative_total_v = 
      self.negative_i_v + self.negative_e_v + self.negative_s_v

    self.dim_percent_v = 100.0 * (self.dim_v / Float(self.dif_v))
    self.int_percent_v = 100.0 * (self.int_v / Float(self.dif_v))
    self.ai_percent_v  = 100.0 * (self.negative_total_v / Float(self.dif_v))

    self.dim_i_s, self.int_i_s, self.positive_i_s, self.negative_i_s = 
      calc_dim_and_int("intrinsic", "self")
    self.dim_e_s, self.int_e_s, self.positive_e_s, self.negative_e_s = 
      calc_dim_and_int("extrinsic", "self")
    self.dim_s_s, self.int_s_s, self.positive_s_s, self.negative_s_s = 
      calc_dim_and_int("systemic", "self")
    self.dif_s = self.dim_i_s + self.dim_e_s + self.dim_s_s
    self.int_s = self.int_i_s + self.int_e_s + self.int_s_s
    self.dim_s = 3 * [self.dim_i_s, self.dim_e_s, self.dim_s_s].max - 
      self.dim_i_s - self.dim_e_s - self.dim_s_s
    self.di_s = 3 * [self.int_i_s, self.int_e_s, self.int_s_s].max -
      self.int_i_s - self.int_e_s - self.int_s_s
    self.dis_s = calc_dis("self")
    self.sq_left = self.dif_s + self.dim_s + self.int_s + self.dis_s
    self.sq_right = self.dim_s + self.int_s + self.dis_s
    self.positive_total_s = 
      self.positive_i_s + self.positive_e_s + self.positive_s_s
    self.negative_total_s = 
      self.negative_i_s + self.negative_e_s + self.negative_s_s

    self.dim_percent_s = 100.0 * (self.dim_s / Float(self.dif_s))
    self.int_percent_s = 100.0 * (self.int_s / Float(self.dif_s))
    self.ai_percent_s  = 100.0 * (self.negative_total_s / Float(self.dif_s))

    self.bqr1 = self.sq_left / Float(self.vq_left)
    self.bqa1 = (self.sq_left + self.vq_left)/2.0

    self.bqr2 = self.sq_right / Float(self.vq_right)
    self.bqa2 = (self.sq_right + self.vq_right)/2.0

    self.cq1 = self.bqr1 * self.bqa1
    self.cq2 = self.bqr2 * self.bqa2

    self.dif1_over_dif2 = 100.0 *
      [self.dif_v, self.dif_s].min / Float([self.dif_v, self.dif_s].max)
  end

private

  def calc_dim_and_int(category_id, part_id)
    dim = 0
    int = 0
    positive = 0
    negative = 0

    category = hvp_elements.where(:category_id => category_id,
                                  :part_id => part_id)
    category.each do |c|
      if c.axiological_norm < 10
        top_box = c.axiological_norm - c.given_value
      else
        top_box = c.given_value - c.axiological_norm
      end
      dim += top_box.abs
      if top_box > 0
        int += (top_box - 2) > 0 ? (top_box - 2) : 0
        positive += top_box
      elsif top_box < 0
        int += (top_box + 2) < 0 ? (top_box + 2).abs : 0
        negative += top_box.abs
      end
    end
    return dim, int, positive, negative
  end

  def calc_dis(part_id)
    dis = 0

    hvp_elements.where(:part_id => part_id).each do |hvp_element|
      axiological_norm = hvp_element.axiological_norm
      given_value = hvp_element.given_value
      
      if ((axiological_norm >= 10) && (given_value < 10))
        dis += 1
      elsif ((axiological_norm < 10) && (given_value >= 10))
        dis += 1
      end
    end
    return dis
  end
end
