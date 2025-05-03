module mmt_v3::liquidity {
    use sui::coin::{Self, Coin};
    use sui::clock::{Clock};
    use mmt_v3::pool::{Self, Pool};
    use mmt_v3::position::{Self, Position};
    use mmt_v3::version::{Self,Version};    

    
    public fun remove_liquidity<X, Y>(
        pool: &mut Pool<X, Y>, 
        position: &mut Position, 
        liquidity: u128, 
        min_amount_x: u64, 
        min_amount_y: u64, 
        clock: &Clock, 
        version: &Version,        
        ctx: &mut TxContext
    ): (Coin<X>, Coin<Y>) {
        abort 0
    }
    
    // adds liquidity and returns refund amount if any.
    public fun add_liquidity<X, Y>(
        pool: &mut Pool<X, Y>, 
        position: &mut Position,
        coin_x: Coin<X>,
        coin_y: Coin<Y>,
        min_amount_x: u64,
        min_amount_y: u64,
        clock: &Clock,
        version: &Version,        
        ctx: &mut TxContext
    ): (Coin<X>, Coin<Y>) {
        abort 0
    }
}
