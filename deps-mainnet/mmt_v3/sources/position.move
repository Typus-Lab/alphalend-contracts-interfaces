
module mmt_v3::position {
    use sui::object::{Self, ID, UID};
    use sui::tx_context::TxContext;

    public struct Position has store, key {
        id: UID,
        pool_id: ID,
        tick_lower_index: u32,
        tick_upper_index: u32,
        liquidity: u128,
    }

    public fun pool_id(self: &Position): ID {
        self.pool_id
    }

    public fun tick_lower_index(self: &Position): u32 {
        self.tick_lower_index
    }

    public fun tick_upper_index(self: &Position): u32 {
        self.tick_upper_index
    }

    public fun liquidity(self: &Position): u128 {
        self.liquidity
    }
}
