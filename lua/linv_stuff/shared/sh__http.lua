//
// HTTP
//

// Variables
LinvLib.api = 'https://api.linv.dev/'
LinvLib.apiParams = ""

// Functions
function LinvLib.isCodeValid(code)
    if code == 200 then
        return true
    else
        return false
    end
end

function LinvLib.httpError(error)
	LinvLib.log("Web request failed! Error details: " .. error, true)
end

function LinvLib.ulrGenerate(endpoint, parameters)
    if !parameters then return LinvLib.api .. endpoint .. LinvLib.apiParams end
    local params = ""
    local first = true
    for k, v in pairs(parameters) do
        if first then
            params = params .. k .. "=" .. v
            first = false
        else
            params = params .. "&" .. k .. "=" .. v
        end
    end
    return LinvLib.api .. endpoint .. "?" .. params .. LinvLib.apiParams
end

function LinvLib.fetch(endpoint, parameters, onSuccess, onError)
    LinvLib.log("Fetching " .. endpoint, true)
    http.Fetch(
        // URL
        LinvLib.ulrGenerate(endpoint, parameters),
        // onSuccess
        function (body, length, headers, code )
            if LinvLib.isCodeValid(code) then
                onSuccess(body, length, headers, code)
            else
                LinvLib.httpError(body)
            end
        end,
        LinvLib.httpError
    )
end

function LinvLib.post(endpoint, parameters, data, onSuccess)
    local bodyData = util.TableToJSON(data)
    LinvLib.log("Posting " .. endpoint, true)
    HTTP(
        {
            url = LinvLib.ulrGenerate(endpoint, parameters),
            method = "POST",
            headers = {
                ["Content-Type"] = "application/json",
                ["Content-Length"] = tostring(#bodyData),
            },
            body = bodyData,
            type = "application/json",
            success = function(code, body, headers)
                if (LinvLib.isCodeValid(code)) then
                    if (onSuccess) then
                        onSuccess(body, length, headers, code)
                    end
                else
                    LinvLib.httpError(body)
                end
            end,
            failed = LinvLib.httpError,
        }
    )
end

/*
// Fetch Example
LinvLib.fetch(
    // Endpoint
    "",
    // Parameters
    { request = "requ" },
    // onSuccess
    function( body, length, headers, code )
        print(body)
    end
)

// Post Example
LinvLib.post(
    // Endpoint
    "",
    // Parameters
    { request = "requ" },
    // Data
    {
        data = "data"
    },
    // onSuccess
    function( body, length, headers, code )
        print(body)
    end
)
*/