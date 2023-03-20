// -- // -- // -- // -- // -- // -- // -- // -- // -- //
// RETROCOMPATIBILITY
// -- // -- // -- // -- // -- // -- // -- // -- // -- //

-- print(language.GetPhrase("linvlib.game_starting"))

function LRespW(w)
    return ScrW() * (w / 1920)
end

function LRespH(h)
    return ScrH() * (h / 1080)
end

function LResp(w, h)
    return LRespW(w), LRespH(h)
end

