
module mmt_v3::pool {
    use sui::object::{Self, ID, UID};
    use sui::tx_context::TxContext;

    public struct Pool<phantom A, phantom B> has key {
        id: UID,
        tick_index_current: u32,
        current_sqrt_price: u64,
    }

    public fun tick_index_current<A, B>(self: &Pool<A, B>): u32 {
        self.tick_index_current
    }

    public fun current_sqrt_price<A, B>(self: &Pool<A, B>): u64 {
        self.current_sqrt_price
    }
} 
