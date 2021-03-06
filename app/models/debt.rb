class Debt < ActiveRecord::Base
  belongs_to :debt_group, foreign_key: :group_id

  # 借方(or貸方)のとき増加する科目か
  # @params [boolean] is_debit true:借方の場合,false:貸方の場合
  # @return [boolean] 増加する項目か
  def isIncrease ( is_debit )
    return is_debit ? false : true
  end
end
