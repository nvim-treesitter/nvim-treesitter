interface ServerCancellationToken {
    isCancellationRequested(): boolean;
    setRequest(requestId: number): void;
                                  // ^ @type
    resetRequest(requestId: number): void;
                                  // ^ @type
}
