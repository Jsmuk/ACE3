/*
 * Author: Dslyecxi, Jonpas
 * Handles cooking a grenade.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_grenadethrowing_fnc_cook
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_grenadeItem", "_grenadeType"];

GVAR(CookingGrenade) = true;

GVAR(ActiveGrenadeItemOld) = GVAR(ActiveGrenadeItem);
GVAR(ActiveGrenadeItem) = _grenadeType createVehicle ((vehicle player) modelToWorldVisual [0, 0.3, 1.6]);
deleteVehicle GVAR(ActiveGrenadeItemOld);

// Wait to see if the player has it in hand. If ever it's not in hand, we exit
// Wait to see if it's not alive. If it's not alive but still in hand, we cancel all the things
[{
    !GVAR(GrenadeInHand) || !alive GVAR(ActiveGrenadeItem)
}, {
    // The grenade is dead but it's still thought to be in hand
    if (GVAR(GrenadeInHand)) then {
        ["Grenade was not alive, yet still thought in hand"] call FUNC(exitThrowMode);
    };
}, []] call EFUNC(common,waitUntilAndExecute);
