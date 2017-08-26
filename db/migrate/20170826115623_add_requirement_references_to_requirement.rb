class AddRequirementReferencesToRequirement < ActiveRecord::Migration[5.1]
  def change
    add_reference :requirements, :satisfies, index: true, null: true
  end
end
