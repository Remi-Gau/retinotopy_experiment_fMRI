function data = feedbackScreen(cfg, expParameters)
    % data = feedbackScreen(cfg, expParameters);
    % gives feedback to the participant
    % the hit rate can be overestimated if there are 2 targets close to each
    % other then a response to the second target can also be counted as a
    % reponse for the first one

    Target = 4;
    Response = 5;

    IsTarget = find(Data(:, 2) == Target);
    IsResp = Data(:, 2) == Response;

    Hit = 0;
    Miss = 0;

    % we check if there is a response in the response window (defined with
    % logical indexing) and update the appropriate counter
    for iTarget = 1:numel(IsTarget)

        RespWin = all([ ...
            Data(:, 1) >= Data(IsTarget(iTarget), 1), ...
            Data(:, 1) < (Data(IsTarget(iTarget), 1) + expParameters.RespWin)], 2);

        if any(all([RespWin IsResp], 2))
            Hit = Hit + 1;
        else
            Miss = Miss + 1;
        end

    end

    FA = sum(IsResp) - Hit;

    Screen('FillRect', cfg.win, expParameters.backgroundColor, cfg.winRect);

    DrawFormattedText(cfg.win, sprintf(expParameters.Hit, Hit, numel(IsTarget)), ...
        'center', cfg.winRect(4) / 4, [0 255 0]);

    DrawFormattedText(cfg.win, sprintf(expParameters.Miss, Miss, numel(IsTarget)), ...
        'center', cfg.winRect(4) / 2, [255 0 0]);

    DrawFormattedText(cfg.win, sprintf(expParameters.FA, FA), ...
        'center', cfg.winRect(4) * 3 / 4, [255 0 0]);

    Screen('Flip', cfg.win);

end