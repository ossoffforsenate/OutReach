class RelationshipsController < ApplicationController
  def index
    # to_a calls 
    @contacts           = current_user.non_self_voters.order(:tier, :sos_id).load
    @secondary_contacts = current_user.secondary_network.order(:tier, :sos_id).load

    @contacted_size = (@contacts + @secondary_contacts).count { |v| !v.not_yet_called? }
    @tier_4_size    = (@contacts + @secondary_contacts).count { |v| v.tier == 4 }

    @contacts           = @contacts.reject { |v| v.tier == 4 }
    @secondary_contacts = @secondary_contacts.reject { |v| v.tier == 4 }
  end
end
